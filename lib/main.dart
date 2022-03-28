import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String itemValue = '';
  List<String> todoItems = [
    'Item 1',
    'Item 2',
    'Item 3'
  ]; //List.empty(growable: true);

  Future<String?> addItemDialog() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('AlertDialog Title'),
        content: TextFormField(
            initialValue: '',
            onChanged: (value) {
              itemValue = value;
            }),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                todoItems.add(itemValue);
                Navigator.pop(context, 'Ok');
              });
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      todoItems.add('value');
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          backgroundColor: Colors.teal,
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: todoItems.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                margin: EdgeInsets.all(2),
                child: Center(
                    child: Text(
                  '${todoItems[index]}',
                  style: TextStyle(fontSize: 18),
                )),
              );
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
              child: FloatingActionButton(
                  child: const Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      todoItems.clear();
                    });
                  })),
        ]) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
