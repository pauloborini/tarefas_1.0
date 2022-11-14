import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/circular_progress.dart';
import '../components/task.dart';
import '../data/task_dao.dart';
import 'form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final Color stanColor = const Color.fromARGB(255, 245, 244, 240);
  final Color purple = const Color.fromARGB(255, 127, 89, 206);
  final Color orange = const Color.fromARGB(255, 253, 156, 115);
  bool opacity = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: stanColor,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 180,
        backgroundColor: stanColor,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Column(
            children: [
              Stack(children: [
                Container(
                  alignment: Alignment.topRight,
                  width: double.infinity,
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          opacity = !opacity;
                        });
                      },
                      child: SizedBox(
                          width: 50,
                          child: Icon(Icons.remove_red_eye, color: purple))),
                ),
                const Center(
                  child: Text(
                    'Olá!',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24), color: orange),
                  child: Center(
                    child: Text(
                        'Tenha um ótimo ${DateFormat('d MMM y').format(DateTime.now())}!',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Rubik',
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Suas Tarefas',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/priority_screen');
                          },
                          child: const Text('Ordenar por Prioridade',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
                                                  isCompleted: 1));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    '${task.name} concluída!'),
                                              ));
                                            },
                                            child: const Text("Concluir",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green,
                                                    fontSize: 18))),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: const Text("Cancelar",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
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
                                              color: Colors.black54,
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
            return const Text('Unknown Error');
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: purple,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(_createRoute()).then(
                (value) => setState(
                  () {},
                ),
              );
        },
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        FormScreen(taskContext: context),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
