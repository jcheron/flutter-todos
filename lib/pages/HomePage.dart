import 'package:firstapp/providers/TodoListModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo lists'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                onPressed: () {},
                label: const Text('Add a new Todo list')),
          ),
          Consumer<TodoListModel>(builder: (context, todolist, child) {
            List<String> myLists = todolist.listNames;
            return ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: todolist.countList,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/todos',
                          arguments: myLists[index]);
                    },
                    leading: Icon(
                      Icons.apps,
                    ),
                    title: Text(myLists[index] +
                        " ( ${todolist.getListCount(myLists[index])})"),
                    dense: false,
                    trailing:
                        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {},
                      ),
                    ]),
                  );
                });
          })
        ],
      ),
    );
  }
}
