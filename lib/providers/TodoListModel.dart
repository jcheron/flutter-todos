import 'package:flutter/widgets.dart';

class TodoListModel extends ChangeNotifier {
  List<String> _todos = List.empty(growable: true);

  addItem(String item) {
    _todos.add(item);
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
}
