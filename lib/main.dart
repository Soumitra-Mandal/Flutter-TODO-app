import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_practice/db_helper.dart';
import 'package:flutter_practice/details_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'todo.dart';
import 'input_screen.dart';

Future main() async {
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  }
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<Todo> todos = [];

  final List<Icon> icons = const [
    Icon(Icons.arrow_upward_rounded, color: Colors.red),
    Icon(Icons.arrow_upward_rounded, color: Color.fromARGB(255, 204, 157, 2)),
    Icon(Icons.arrow_downward_rounded, color: Colors.green),
  ];

  @override
  Widget build(BuildContext context) {
    var dbHelper = DatabaseHelper();
    dbHelper.todos().then((values) => setState(() => {todos = values}));
    return Scaffold(
      appBar: AppBar(
        title: const Text("My To-Dos"),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView.builder(
        itemCount: todos.length * 2,
        itemBuilder: (context, index) {
          if (index % 2 != 0) {
            return const Divider(
              height: 10,
              thickness: 1,
              color: Colors.grey,
            );
          }
          return ListTile(
            leading: icons[todos[index ~/ 2].priority],
            title: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(todos[index ~/ 2].title),
            ),
            subtitle: Text(todos[index ~/ 2].createdOn),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                            todo: todos[index ~/ 2],
                          ))),
            },
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.redAccent,
              onPressed: () {
                setState(() {
                  //todos.remove(todos[index ~/ 2]);
                  dbHelper.deleteTodo(todos[index ~/ 2].id);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Todo result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const InputScreen()),
          );
          if (result.title != '') {
            setState(() {
              //todos.add(result);
              dbHelper.insertTodo(result);
            });
          }
        },
      ),
    );
  }
}
