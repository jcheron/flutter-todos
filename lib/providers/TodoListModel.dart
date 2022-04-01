import 'package:firstapp/database/TodoElement.dart';
import 'package:firstapp/database/TodoList.dart';
import 'package:firstapp/main.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class TodoListModel extends ChangeNotifier {
  late String activeListName;

  TodoListModel() {
    Box box = Hive.box<TodoList>(MyApp.BOXNAME);
    /*TodoList list=TodoList()
    ..name='Courses'
    ..elements=[TodoElement('Eau'),TodoElement('Pain'),TodoElement('Beurre')];
    box.add(list);*/
    List<TodoList> lists = box.values.toList().cast();
    lists.forEach((list) {
      myLists[list.name] = list.elements;
    });
  }

  Map<String, List<TodoElement>> myLists = {};
  List<TodoElement> _todos = List.empty(growable: true);

  addItem(String item) {
    _todos.add(TodoElement(item));
    notifyListeners();
  }

  setActiveList(String name) {
    if (myLists.containsKey(name)) {
      activeListName = name;
      _todos = myLists[name] as List<TodoElement>;
      //notifyListeners();
    }
  }

  get listNames {
    return myLists.keys.toList();
  }

  bool addNewList(String name) {
    if (!myLists.containsKey(name)) {
      myLists[name] = List.empty(growable: true);
      notifyListeners();
      return true;
    }
    return false;
  }

  get countList {
    return myLists.length;
  }

  int? getListCount(String name) {
    return myLists[name]?.length;
  }

  TodoElement getItem(int index) {
    if (index == -1) {
      return TodoElement('');
    }
    return _todos.elementAt(index);
  }

  insertOrUpdate(int index, String newValue, bool checked) {
    if (index == -1) {
      addItem(newValue);
    } else {
      update(index, newValue, checked);
    }
  }

  toggleCheck(int index) {
    if (index != -1) {
      _todos[index].checked = !_todos[index].checked;
      notifyListeners();
    }
  }

  update(int index, String newValue, bool checked) {
    _todos[index].name = newValue;
    _todos[index].checked = checked;
    save();
    notifyListeners();
  }

  get todos {
    return _todos;
  }

  remove(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }

  clear() {
    _todos.clear();
    notifyListeners();
  }

  save() async {
    //Sauvegarder activeListName et ses items (myList)
    Box box = Hive.box<TodoList>(MyApp.BOXNAME);
    TodoList list =
        await box.values.firstWhere((element) => element.name == activeListName)
          ?..elements = _todos
          ..save();
  }
}
