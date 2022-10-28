import '../components/task.dart';
import 'database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tasktable('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_priority INTEGER, '
      '$_image TEXT, '
      '$_lvl INTEGER)';

  static const String _tasktable = 'taskTable';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _priority = 'priority';
  static const String _image = 'image';
  static const String _lvl = 'lvl';

  save(Task task) async {
    final Database dataBaseLocal = await getDatabase();
    var itemExists = await find(task.name);
    if (itemExists.isEmpty) {
      return await dataBaseLocal.insert(_tasktable, _toMap(task));
    } else {
      return await dataBaseLocal.update(_tasktable, _toMap(task),
          where: '$_name = ?', whereArgs: [task.name]);
    }
  }

  Future<int> getLengthDB() async {
    final Database dataBaseLocal = await getDatabase();
    final List<Map<String, dynamic>> result =
        await dataBaseLocal.query(_tasktable);
    if (result.isEmpty) {
      const int varForID = 1;
      return varForID;
    } else {
      int id = result.length;
      final varForID = id++;
      return varForID;
    }
  }

  Future<List<Task>> findAll() async {
    final Database dataBaseLocal = await getDatabase();
    final List<Map<String, dynamic>> result =
        await dataBaseLocal.query(_tasktable);
    return toList(result);
  }

  Future<List<Task>> find(String nameTask) async {
    final Database dataBaseLocal = await getDatabase();
    final List<Map<String, dynamic>> result = await dataBaseLocal
        .query(_tasktable, where: '$_name = ?', whereArgs: [nameTask]);
    return toList(result);
  }

  delete(String nameTask) async {
    final Database dataBaseLocal = await getDatabase();
    return dataBaseLocal
        .delete(_tasktable, where: '$_name = ?', whereArgs: [nameTask]);
  }

  List<Task> toList(List<Map<String, dynamic>> taskList) {
    final List<Task> tasks = [];
    for (Map<String, dynamic> row in taskList) {
      final Task task = Task(
        row[_id],
        row[_name],
        row[_priority],
        row[_image],
        row[_lvl],
      );
      tasks.add(task);
    }
    return tasks;
  }

  Map<String, dynamic> _toMap(Task task) {
    final Map<String, dynamic> taskMap = {};
    taskMap[_name] = task.name;
    taskMap[_priority] = task.priority;
    taskMap[_image] = task.image;
    taskMap[_lvl] = task.lvl;
    return taskMap;
  }
}
