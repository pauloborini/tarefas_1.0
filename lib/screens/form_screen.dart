import 'package:flutter/material.dart';
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
  final String noPhoto = 'assets/images/nophoto.webp';

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
        appBar: AppBar(
          title: const Text(
            'Nova Tarefa',
            style: TextStyle(fontSize: 24, color: Colors.deepPurple),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0x80FAFAF7),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(width: 3, color: Colors.deepPurple)),
              width: 375,
              height: 650,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
                        fillColor: const Color(0xB6AAAAFF),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24)),
                        hintText: 'Nome da Tarefa',
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
                        fillColor: const Color(0xB6AAAAFF),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24)),
                        hintText: 'Prioridade de 0 a 5',
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      validator: (value) {
                        if (valueValidator(value)) {
                          return 'Insira uma URL de Imagem';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.url,
                      controller: imageController,
                      onChanged: (text) {
                        setState(() {});
                      },
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        fillColor: const Color(0xB6AAAAFF),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24)),
                        hintText: 'Link da imagem',
                        filled: true,
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          width: 2,
                          color: Colors.deepPurple,
                        )),
                    child: ClipRRect(
                      child: Image.network(
                        fit: BoxFit.cover,
                        imageController.text,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Image.asset(
                            noPhoto,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final int correctID = await TaskDao().getLengthDB();
                            await TaskDao().save(Task(
                              correctID,
                              nameController.text,
                              int.parse(priorityController.text),
                              imageController.text,
                            ));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Concluído'),
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Adicionar')),
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
