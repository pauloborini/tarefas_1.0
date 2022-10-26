import '../components/task.dart';
import 'database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tarefastable('
      '$_id INTEGER PRIMARY KEY, '
      '$_nome TEXT, '
      '$_prioridade INTEGER, '
      '$_image TEXT, '
      '$_nivel INTEGER)';

  static const String _tarefastable = 'tarefasTable';
  static const String _id = 'id';
  static const String _nome = 'nome';
  static const String _prioridade = 'prioridade';
  static const String _image = 'image';
  static const String _nivel = 'nivel';

  save(Task tarefa) async {
    final Database bancoDeDados = await getDatabase();
    var itemExists = await find(tarefa.nome);
    if (itemExists.isEmpty) {
      return await bancoDeDados.insert(_tarefastable, _toMap(tarefa));
    } else {
      return await bancoDeDados.update(_tarefastable, _toMap(tarefa),
          where: '$_nome = ?', whereArgs: [tarefa.nome]);
    }
  }


  Future<int> pegarTamanhoDB() async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tarefastable);
    if (result.isEmpty) {
      const int varParaID = 1;
      return varParaID;
    } else {
      int id = result.length;
      final varParaID = id++;
      return varParaID;
    }
  }

  Future<List<Task>> findAll() async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tarefastable);
    return toList(result);
  }

  Future<List<Task>> find(String nomeDaTarefa) async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados
        .query(_tarefastable, where: '$_nome = ?', whereArgs: [nomeDaTarefa]);
    return toList(result);
  }

  delete(String nomeDaTarefa) async {
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados
        .delete(_tarefastable, where: '$_nome = ?', whereArgs: [nomeDaTarefa]);
  }

  List<Task> toList(List<Map<String, dynamic>> listaDeTarefas) {
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in listaDeTarefas) {
      final Task tarefa = Task(
        linha[_id],
        linha[_nome],
        linha[_prioridade],
        linha[_image],
        linha[_nivel],
      );
      tarefas.add(tarefa);
    }
    return tarefas;
  }

  Map<String, dynamic> _toMap(Task tarefa) {
    final Map<String, dynamic> mapaTarefa = {};
    mapaTarefa[_nome] = tarefa.nome;
    mapaTarefa[_prioridade] = tarefa.prioridade;
    mapaTarefa[_image] = tarefa.image;
    mapaTarefa[_nivel] = tarefa.nivel;
    return mapaTarefa;
  }
}
