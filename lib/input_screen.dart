import 'package:flutter/material.dart';
import 'package:flutter_practice/todo.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  int priority = 2;
  var priorities = ['high', "medium", "low"];
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(
                context,
                Todo('', '', '',
                    DateFormat.yMEd().add_jms().format(DateTime.now()), 0)),
          ),
          title: const Text("Create To-Do"),
          backgroundColor: Colors.redAccent,
        ),
        body: Container(
          color: Colors.white,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(234, 189, 185, 185),
                    blurRadius: 3.0,
                    spreadRadius: 1.0,
                    offset: Offset(0, 0))
              ],
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  color: Colors.white),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Title',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Description',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Priority',
                        ),
                        value: priorities[priority],
                        items: priorities.map((String priority) {
                          return DropdownMenuItem(
                            value: priority,
                            child: Text(priority),
                          );
                        }).toList(),
                        onChanged: (String? newvalue) => {
                              setState(() =>
                                  {priority = priorities.indexOf(newvalue!)})
                            }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          Todo(
                              const Uuid().v4(),
                              titleController.text,
                              descriptionController.text,
                              DateFormat.yMEd()
                                  .add_jms()
                                  .format(DateTime.now()),
                              priority),
                        );
                      },
                      child: const Text("Add Todo"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
