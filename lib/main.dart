import 'package:firstapp/models/Todo.dart';
import 'package:firstapp/pages/HomePage.dart';
import 'package:firstapp/pages/TodoListPage.dart';
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
      title: 'Todos lists application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/todos': (context) => const TodoListPage(title: 'Todos'),
      },
    );
  }
}
