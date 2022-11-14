import '../components/task.dart';
import 'database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tasksTable('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_priority INTEGER, '
      '$_date TEXT, '
      '$_isCompleted INTEGER, '
      '$_lvl INTEGER)';

  static const String _tasksTable = 'tasksTable';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _priority = 'priority';
  static const String _date = 'date';
  static const String _isCompleted = 'isCompleted';
  static const String _lvl = 'lvl';

  save(Task task) async {
    final Database dataBaseLocal = await getDatabase();
    var itemExists = await find(task.name);
    if (itemExists.isEmpty) {
      return await dataBaseLocal.insert(_tasksTable, _toMap(task));
    } else {
      return await dataBaseLocal.update(_tasksTable, _toMap(task),
          where: '$_name = ?', whereArgs: [task.name]);
    }
  }

  Future<List<Task>> orderByPriority() async {
    final Database dataBaseLocal = await getDatabase();
    final List<Map<String, dynamic>> result =
        await dataBaseLocal.query(_tasksTable, orderBy: "priority DESC", where: "$_isCompleted = ?", whereArgs: [0]);
    return toList(result);
  }

  Future<List<Task>> findAll() async {
    final Database dataBaseLocal = await getDatabase();
    final List<Map<String, dynamic>> result = await dataBaseLocal
        .rawQuery('''SELECT * FROM $_tasksTable WHERE $_isCompleted LIKE 0''');
    return toList(result);
  }

  Future<List<Task>> findAllCompleted() async {
    final Database dataBaseLocal = await getDatabase();
    final List<Map<String, dynamic>> result = await dataBaseLocal
        .rawQuery('''SELECT * FROM $_tasksTable WHERE $_isCompleted LIKE 1''');
    return toList(result);
  }

  // groupBy: '$_isCompleted = ${int.parse('0')}'
  Future<List<Task>> find(String nameTask) async {
    final Database dataBaseLocal = await getDatabase();
    final List<Map<String, dynamic>> result = await dataBaseLocal
        .query(_tasksTable, where: '$_name = ?', whereArgs: [nameTask]);
    return toList(result);
  }

  delete(String nameTask) async {
    final Database dataBaseLocal = await getDatabase();
    return dataBaseLocal
        .delete(_tasksTable, where: '$_name = ?', whereArgs: [nameTask]);
  }

  List<Task> toList(List<Map<String, dynamic>> taskList) {
    final List<Task> tasks = [];
    for (Map<String, dynamic> row in taskList) {
      final Task task = Task(
          id: row[_id],
          name: row[_name],
          priority: row[_priority],
          date: row[_date],
          isCompleted: row[_isCompleted],
          lvl: row[_lvl]);
      tasks.add(task);
    }
    return tasks;
  }

  Map<String, dynamic> _toMap(Task task) {
    final Map<String, dynamic> taskMap = {};
    taskMap[_name] = task.name;
    taskMap[_priority] = task.priority;
    taskMap[_date] = task.date;
    taskMap[_isCompleted] = task.isCompleted;
    taskMap[_lvl] = task.lvl;
    return taskMap;
  }
}
