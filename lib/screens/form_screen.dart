import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tarefas_game/components/adaptative_date_picker.dart';
import '../components/task.dart';
import '../data/task_dao.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key, required this.taskContext}) : super(key: key);

  final BuildContext taskContext;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  final String noPhoto = 'assets/images/nophoto.webp';
  final Color stanColor = const Color.fromARGB(255, 245, 244, 240);
  final Color purple = const Color.fromARGB(255, 127, 89, 206);
  final Color orange = const Color.fromARGB(255, 245, 187, 167);
  final Color fontColor = Colors.black87;

  bool valueValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: stanColor,
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_downward)),
          toolbarHeight: 85,
          centerTitle: true,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          backgroundColor: stanColor,
          title: const Text(
            'Nova Tarefa',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 26,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              color: stanColor,
              width: 375,
              height: 650,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 16),
                    child: SizedBox(
                      width: 320,
                      height: 60,
                      child: TextFormField(
                        validator: (String? value) {
                          if (valueValidator(value)) {
                            return 'Insira o nome da Tarefa';
                          }
                          return null;
                        },
                        controller: nameController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          label: const Padding(
                            padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: Text('Nome da Tarefa'),
                          ),
                          fillColor: orange,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(24)),
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
                    child: SizedBox(
                      width: 320,
                      height: 60,
                      child: TextFormField(
                        validator: (value) {
                          if (valueValidator(value) || int.parse(value!) > 5) {
                            return 'Insira a prioridade da tarefa';
                          }
                          return null;
                        },
                        controller: priorityController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          fillColor: orange,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(24)),
                          label: const Padding(
                            padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: Text('Prioridade'),
                          ),
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                  AdaptativeDatePicker(
                      selectedDate: _selectedDate,
                      onDateChanged: (newDate) {
                        setState(() {
                          _selectedDate = newDate;
                        });
                      }),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await TaskDao().save(Task(
                              name: nameController.text,
                              priority: int.parse(priorityController.text),
                              date: _selectedDate.toIso8601String(),
                              isCompleted: 0,
                              lvl: 0,
                            ));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${nameController.text} Criado'),
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          '  Adicionar Tarefa  ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
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
