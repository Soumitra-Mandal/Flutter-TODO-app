import 'package:flutter/material.dart';
import 'package:flutter_practice/todo.dart';

class DetailsScreen extends StatelessWidget {
  final Todo todo;
  final priorities = ['high', "medium", "low"];

  DetailsScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            todo.title,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.redAccent,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Text(
                "Priority: ${priorities[todo.priority]}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                todo.description,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "created on ${todo.createdOn}",
                style: const TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }
}
