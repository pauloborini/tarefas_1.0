import 'package:flutter/material.dart';
import '../components/base_app_bar.dart';
import '../components/circular_progress.dart';
import '../components/task.dart';
import '../components/utilities/colors_and_vars.dart';
import '../components/utilities/functions.dart';
import '../data/task_dao.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  bool opacity = true;
  bool orderBy = false;

  void orderByChanger() {
    orderBy = !orderBy;
  }

  @override
  Widget build(BuildContext context) {
    if (orderBy == false) {
      return Scaffold(
          extendBody: true,
          appBar: BaseAppBar(
            label: 'Suas Tarefas',
            appBar: AppBar(),
            opacityFunc: () {
              setState(() {
                opacity = !opacity;
              });
            },
            orderBy: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () {
                  setState(() {
                    orderBy = !orderBy;
                  });
                },
                child: const Text('Ordenar por Prioridade',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          ),
          backgroundColor: stanColor,
          body: AnimatedOpacity(
            opacity: opacity ? 1 : 0,
            duration: const Duration(milliseconds: 400),
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
                            final Task task = items[index];
                            return Dismissible(
                              key: ValueKey<Task>(task),
                              direction: DismissDirection.horizontal,
                              confirmDismiss:
                                  (DismissDirection direction) async {
                                if (direction == DismissDirection.startToEnd) {
                                  return await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Confirmação"),
                                          content: const Text(
                                            "Você quer concluir a tarefa?",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(true);
                                                  TaskDao().save(Task(
                                                    name: task.name,
                                                    priority: task.priority,
                                                    date: task.date,
                                                    isCompleted: 1,
                                                    lvl: 100,
                                                  ));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    duration: const Duration(
                                                        seconds: 2),
                                                    content: Text(
                                                        '${task.name} concluída!'),
                                                  ));
                                                },
                                                child: const Text("Concluir",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.green,
                                                        fontSize: 18))),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(false);
                                              },
                                              child: const Text("Cancelar",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: fontColor,
                                                      fontSize: 18)),
                                            ),
                                          ],
                                        );
                                      });
                                } else {
                                  return await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Confirmação"),
                                        content: const Text(
                                          "Você quer deletar a tarefa?",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(true);
                                                TaskDao().delete(task.name);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        duration:
                                                            const Duration(
                                                                seconds: 2),
                                                        content: Text(
                                                            '${task.name} apagado')));
                                              },
                                              child: const Text(
                                                "Deletar",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: const Text(
                                              "Cancelar",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: fontColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              background: Container(
                                color: stanColor,
                                child: const Align(
                                  alignment: Alignment(-0.9, 0),
                                  child: Icon(
                                    Icons.task_alt,
                                    color: Colors.green,
                                    size: 40,
                                  ),
                                ),
                              ),
                              secondaryBackground: Container(
                                color: stanColor,
                                child: const Align(
                                  alignment: Alignment(0.9, 0),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                ),
                              ),
                              child: Container(child: task),
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
                return const CircularProgress('Carregando...');
              },
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: purple,
            child: const Icon(Icons.add_task_rounded),
            onPressed: () {
              Navigator.of(context).push(createRoute()).then(
                    (value) => setState(
                      () {},
                    ),
                  );
            },
          ));
    } else {
      return Scaffold(
        backgroundColor: stanColor,
        appBar: BaseAppBar(
          label: 'Suas Tarefas',
          appBar: AppBar(),
          opacityFunc: () {
            setState(() {
              opacity = !opacity;
            });
          },
          orderBy: TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                setState(() {
                  orderBy = !orderBy;
                });
              },
              child: const Text('Ordenar por Entrada',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
        ),
        body: AnimatedOpacity(
          opacity: opacity ? 1 : 0,
          duration: const Duration(milliseconds: 400),
          child: FutureBuilder<List<Task>>(
            future: TaskDao().orderByPriority(),
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
                          final Task task = items[index];
                          return Dismissible(
                            key: ValueKey<Task>(task),
                            direction: DismissDirection.horizontal,
                            confirmDismiss: (DismissDirection direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                return await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Confirmação"),
                                        content: const Text(
                                          "Você quer concluir a tarefa?",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(true);
                                                TaskDao().save(Task(
                                                  name: task.name,
                                                  priority: task.priority,
                                                  date: task.date,
                                                  isCompleted: 1,
                                                  lvl: 100,
                                                ));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  duration: const Duration(
                                                      seconds: 2),
                                                  content: Text(
                                                      '${task.name} concluída!'),
                                                ));
                                              },
                                              child: const Text("Concluir",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green,
                                                      fontSize: 18))),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: const Text("Cancelar",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: fontColor,
                                                    fontSize: 18)),
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                return await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Confirmação"),
                                      content: const Text(
                                        "Você quer deletar a tarefa?",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                              TaskDao().delete(task.name);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      duration: const Duration(
                                                          seconds: 2),
                                                      content: Text(
                                                          '${task.name} apagado')));
                                            },
                                            child: const Text(
                                              "Deletar",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: const Text(
                                            "Cancelar",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: fontColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            background: Container(
                              color: stanColor,
                              child: const Align(
                                alignment: Alignment(-0.9, 0),
                                child: Icon(
                                  Icons.task_alt,
                                  color: Colors.green,
                                  size: 40,
                                ),
                              ),
                            ),
                            secondaryBackground: Container(
                              color: stanColor,
                              child: const Align(
                                alignment: Alignment(0.9, 0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ),
                            ),
                            child: Container(child: task),
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
              return const CircularProgress('Carregando...');
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: purple,
          child: const Icon(Icons.add_task_rounded),
          onPressed: () {
            Navigator.of(context).push(createRoute()).then(
                  (value) => setState(
                    () {},
                  ),
                );
          },
        ),
      );
    }
  }
}
