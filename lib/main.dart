import 'package:firstapp/providers/TodoListModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => TodoListModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Todo items'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String itemValue = '';

  Future<String?> addItemDialog([int index = -1]) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('AlertDialog Title'),
        content: Consumer<TodoListModel>(builder: (context, todoList, child) {
          return TextFormField(
              initialValue: (index == -1) ? '' : todoList.todos[index],
              onChanged: (value) {
                itemValue = value;
              });
        }),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          Consumer<TodoListModel>(builder: (context, todoList, child) {
            return TextButton(
              onPressed: () {
                setState(() {
                  todoList.addItem(itemValue);
                  Navigator.pop(context, 'Ok');
                });
              },
              child: const Text('OK'),
            );
          }),
        ],
      ),
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
          List<String> todos = todolist.todos;
          return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  hoverColor: Colors.teal,
                  leading: Icon(
                    Icons.apps,
                  ),
                  title: Text(todos[index]),
                  dense: false,
                  trailing:
                      Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {},
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
