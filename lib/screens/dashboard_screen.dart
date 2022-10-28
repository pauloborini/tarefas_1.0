import 'package:flutter/material.dart';
import '../components/circular_progress.dart';
import '../components/task.dart';
import '../data/task_dao.dart';
import 'form_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool opacity = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 24, 8),
            child: InkWell(
                onTap: () {
                  setState(() {
                    opacity = !opacity;
                  });
                },
                child: const SizedBox(
                    width: 50,
                    child: Icon(
                      Icons.remove_red_eye,
                      color: Colors.deepPurple,
                    ))),
          )
        ],
        title: const Text(
          'Tarefas',
          style: TextStyle(color: Colors.deepPurple, fontSize: 24),
        ),
      ),
      body: AnimatedOpacity(
        opacity: opacity ? 1 : 0,
        duration: const Duration(milliseconds: 400),
        child: Container(
          color: Colors.black12,
          child: FutureBuilder<List<Task>>(
            future: TaskDao().findAll(),
            builder: (context, snapshot) {
              List<Task>? items = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  const CircularProgress('Carregando');
                  break;
                case ConnectionState.active:
                  break;
                case ConnectionState.done:
                  if (snapshot.hasData && items != null) {
                    if (items.isNotEmpty) {
                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Task tasks = items[index];
                          return Dismissible(
                            key: ValueKey<Task>(tasks),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              setState(() {});
                            },
                            confirmDismiss: (DismissDirection direction) async {
                              return await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Confirmação"),
                                    content: const Text(
                                        "Você quer deletar a tarefa?"),
                                    actions: <Widget>[
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                            TaskDao().delete(tasks.name);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        '${tasks.name} apagada')));
                                          },
                                          child: const Text("Deletar")),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        child: const Text("Cancelar"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            background: Container(
                              color: Colors.red,
                              child: const Align(
                                alignment: Alignment(-0.9, 0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            child: Container(child: tasks),
                          );
                        },
                      );
                    }
                  }
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                      ),
                      Text(
                        'Adicione uma tarefa',
                        style: TextStyle(fontSize: 24),
                      )
                    ],
                  ));
              }
              return const Text('Unknown Error');
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormScreen(taskContext: context),
            ),
          ).then(
            (value) => setState(
              () {},
            ),
          );
        },
      ),
    );
  }
}
