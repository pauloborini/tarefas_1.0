import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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
  final Color stanColor = const Color.fromARGB(255, 245, 244, 240);
  final Color purple = const Color.fromARGB(255, 127, 89, 206);
  final Color orange = const Color.fromARGB(255, 253, 156, 115);
  bool opacity = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: stanColor,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, //top bar color
        ),
        centerTitle: true,
        toolbarHeight: 150,
        backgroundColor: stanColor,
        elevation: 0,
        title: Column(
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
                      'Tenha um ótimo ' +
                          DateFormat('d MMM y').format(DateTime.now()) +
                          '!',
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
              child: Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Suas Tarefas',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
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
                                  content:
                                      const Text("Você quer deletar a tarefa?"),
                                  actions: <Widget>[
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                          TaskDao().delete(tasks.name);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      '${tasks.name} apagado')));
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
                            color: stanColor,
                            child: const Align(
                              alignment: Alignment(-0.9, 0),
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 40,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: purple,
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
