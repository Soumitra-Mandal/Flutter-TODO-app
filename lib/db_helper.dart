import 'package:flutter_practice/todo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  late final Future<Database> database;
  DatabaseHelper() {
    database = createOrOpenDb();
  }

  Future<Database> createOrOpenDb() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'todos_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE todos(id TEXT PRIMARY KEY, title TEXT, description TEXT, createdOn TEXT, priority INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertTodo(Todo todo) async {
    final db = await database;
    await db.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Todo>> todos() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('todos');

    return List.generate(maps.length, (i) {
      return Todo(
        maps[i]['id'],
        maps[i]['title'],
        maps[i]['description'],
        maps[i]['createdOn'],
        maps[i]['priority'],
      );
    });
  }

  Future<void> deleteTodo(String id) async {
    final Database db = await database;

    await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

// Use this later to enhance response time by limiting calls to DB
  void commitToDb(List<Todo> data) async {
    final Database db = await database;
    Batch batch = db.batch();
    for (final item in data) {
      batch.insert('todos', item.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }
}
