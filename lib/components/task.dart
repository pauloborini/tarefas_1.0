import 'package:flutter/material.dart';
import '../data/task_dao.dart';
import 'star_priority.dart';

class Task extends StatefulWidget {
  final int id;
  final String name;
  final int priority;
  final String image;
  int lvl;

  Task(this.id, this.name, this.priority, this.image, [this.lvl = 0]);


  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {

  final Color stanColor = const Color.fromARGB(255, 245, 244, 240);
  final Color purple = const Color.fromARGB(255, 127, 89, 206);
  final Color orange = const Color.fromARGB(255, 253, 156, 115);

  bool assetOrNetwork() {
    if (widget.image.contains('http')) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: purple,
              borderRadius: BorderRadius.circular(24),
            ),
            height: 100,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(24)),
                      width: 80,
                      height: 80,
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
                          child: Text(widget.name,
                              style:  TextStyle(
                                  color: purple,
                                  fontSize: 20,
                                  overflow: TextOverflow.ellipsis, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Priority(widget.priority),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                      child: SizedBox(
                        width: 52,
                        height: 52,
                        child: ElevatedButton(
                          onLongPress: () {
                            widget.lvl = 0;
                            setState(() {
                              TaskDao().save(
                                Task(widget.id, widget.name, widget.priority,
                                    widget.image, widget.lvl),
                              );
                            });
                          },
                          onPressed: () {
                            setState(() {
                              widget.lvl++;
                            });
                            TaskDao().save(
                              Task(widget.id, widget.name, widget.priority,
                                  widget.image, widget.lvl),
                            );
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: LinearProgressIndicator(
                          value: widget.lvl / 50,
                          backgroundColor: Colors.purple[200],
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                      child: Text(
                        'Nivel: ${widget.lvl}',
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
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
