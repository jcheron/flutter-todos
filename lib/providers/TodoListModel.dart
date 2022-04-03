import 'package:firstapp/database/TodoElement.dart';
import 'package:firstapp/database/TodoList.dart';
import 'package:firstapp/main.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class TodoListModel extends ChangeNotifier {
  late String activeListName;

  TodoListModel() {
    List<TodoList> lists = box.values.toList().cast();
    lists.forEach((list) {
      myLists[list.name] = list.elements;
    });
  }

  Map<String, List<TodoElement>> myLists = {};
  List<TodoElement> _todos = List.empty(growable: true);

  addItem(String item, bool checked) {
    _todos.add(TodoElement(item, checked));
    save();
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
      addItem(newValue, checked);
    } else {
      update(index, newValue, checked);
    }
  }

  toggleCheck(int index) {
    if (index != -1) {
      _todos[index].checked = !_todos[index].checked;
      save();
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
    save();
    notifyListeners();
  }

  clear() {
    _todos.clear();
    save();
    notifyListeners();
  }

  Box<TodoList> get box {
    return Hive.box<TodoList>(MyApp.BOXNAME);
  }

  save() async {
    //Sauvegarder activeListName et ses items (myList)
    TodoList list =
        box.values.firstWhere((element) => element.name == activeListName)
          ..elements = _todos
          ..save();
  }
}
