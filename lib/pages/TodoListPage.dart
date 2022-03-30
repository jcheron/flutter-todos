import 'package:firstapp/models/Todo.dart';
import 'package:firstapp/providers/TodoListModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  String itemValue = '';

  Future<String?> addItemDialog([int index = -1]) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => FocusTraversalGroup(
          child: AlertDialog(
        title: const Text('Todo element'),
        content: Consumer<TodoListModel>(builder: (context, todoList, child) {
          return Row(mainAxisSize: MainAxisSize.min, children: [
            Checkbox(
                value: todoList.getItem(index).checked,
                onChanged: todoList.toggleCheck(index)),
            Flexible(
                child: TextFormField(
                    autofocus: true,
                    initialValue:
                        (index == -1) ? '' : todoList.getItem(index).name,
                    onChanged: (value) {
                      itemValue = value;
                    }))
          ]);
        }),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          Consumer<TodoListModel>(builder: (context, todoList, child) {
            return TextButton(
              onPressed: () {
                todoList.insertOrUpdate(index, itemValue);
                Navigator.pop(context, 'Okay');
              },
              child: const Text('Okay'),
            );
          }),
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.teal,
        ),
        body: Consumer<TodoListModel>(builder: (context, todolist, child) {
          List<Todo> todos = todolist.todos;
          return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.apps,
                      ),
                      Checkbox(
                          value: todos[index].checked,
                          onChanged: (value) {
                            todolist.toggleCheck(index);
                          })
                    ],
                  ),
                  title: Text(todos[index].name),
                  dense: false,
                  trailing:
                      Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        addItemDialog(index);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        todolist.remove(index);
                      },
                    ),
                  ]),
                );
              });
        }),
        floatingActionButton: Stack(children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(25.0),
              child: FloatingActionButton(
                onPressed: addItemDialog,
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Consumer<TodoListModel>(builder: (context, todoList, child) {
              return FloatingActionButton(
                  child: const Icon(Icons.cancel),
                  onPressed: () {
                    todoList.clear();
                  });
            }),
          ),
        ]) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
