import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/task_dao.dart';
import 'star_priority.dart';
import 'utilities/colors_and_vars.dart';

class Task extends StatefulWidget {
  final int? id;
  final String name;
  final int priority;
  final String date;
  final int isCompleted;
  int lvl;

  Task(
      {super.key,
      this.id,
      required this.name,
      required this.priority,
      required this.date,
      required this.isCompleted,
      required this.lvl});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool showLvlButton = false;

  getLvl() {
    if (widget.lvl < 100) {
      showLvlButton = true;
    } else if (widget.lvl > 99) {
      setState(() {
        showLvlButton = false;
      });
    } else if (widget.lvl >= 100) {
      setState(() {
        showLvlButton = false;
      });
    }
  }

  @override
  void initState() {
    getLvl();
    super.initState();
  }

  @override
  void dispose() {
    widget.lvl;
    super.dispose();
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
            height: 90,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.name,
                              style: const TextStyle(
                                  color: purple,
                                  fontSize: 20,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(1, 5, 0, 0),
                            child: Text(DateFormat('EEE, dd/MM')
                                .format(DateTime.parse(widget.date))),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                      child: Visibility(
                        visible: showLvlButton,
                        child: SizedBox(
                          width: 52,
                          height: 52,
                          child: ElevatedButton(
                            onLongPress: () {
                              setState(() {
                                TaskDao().save(
                                  Task(
                                    name: widget.name,
                                    priority: widget.priority,
                                    date: widget.date,
                                    isCompleted: 0,
                                    lvl: 0,
                                  ),
                                );
                              });
                            },
                            onPressed: () {
                              setState(() {
                                if (widget.lvl < 100) {
                                  widget.lvl++;
                                  getLvl();
                                } else if (widget.lvl >= 100) {
                                  return;
                                }
                              });
                              TaskDao().save(
                                Task(
                                  name: widget.name,
                                  priority: widget.priority,
                                  date: widget.date,
                                  isCompleted: 0,
                                  lvl: widget.lvl,
                                ),
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
                        child: Priority(
                          priority: widget.priority,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                      child: Text(
                        'Nivel: ${widget.lvl}',
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
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
