
import 'package:flutter/material.dart';
import '../data/task_dao.dart';
import 'estrelas_prioridades.dart';

class Task extends StatefulWidget {
  final int id;
  final String nome;
  final int prioridade;
  final String image;
  int nivel;

  Task(this.id, this.nome, this.prioridade, this.image,
      [this.nivel = 0, Key? key]);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool assetOrNetwork() {
    if (widget.image.contains('http')) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0x9D160354),
              borderRadius: BorderRadius.circular(24),
            ),
            height: 140,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(24)),
                      width: 80,
                      height: 100,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: assetOrNetwork()
                              ? Image.asset(
                                  widget.image,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  widget.image,
                                  fit: BoxFit.cover,
                                )),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(widget.nome,
                              style: const TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 24,
                                  overflow: TextOverflow.ellipsis)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Prioridade(widget.prioridade),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                      child: SizedBox(
                        width: 52,
                        height: 52,
                        child: ElevatedButton(
                          onLongPress: (){
                            widget.nivel = 0;
                            setState(() {
                              TaskDao().save(
                                Task(widget.id, widget.nome, widget.prioridade,
                                    widget.image, widget.nivel),
                              );
                            });
                          },
                          onPressed: () {
                            setState(() {
                              widget.nivel++;
                            });
                            TaskDao().save(
                              Task(widget.id, widget.nome, widget.prioridade,
                                  widget.image, widget.nivel),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(Icons.arrow_drop_up),
                              Text(
                                'UP',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.deepPurple,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                        child: LinearProgressIndicator(
                          value: widget.nivel / 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                      child: Text(
                        'Nivel: ${widget.nivel}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
