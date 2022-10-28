import 'package:flutter/material.dart';

class Priority extends StatelessWidget {
  final int priority;

  const Priority(this.priority, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star,
            size: 15,
            color:
                (priority >= 1) ? Colors.deepPurpleAccent : Colors.purple[100]),
        Icon(Icons.star,
            size: 15,
            color:
                (priority >= 2) ? Colors.deepPurpleAccent : Colors.purple[100]),
        Icon(Icons.star,
            size: 15,
            color:
                (priority >= 3) ? Colors.deepPurpleAccent : Colors.purple[100]),
        Icon(Icons.star,
            size: 15,
            color:
                (priority >= 4) ? Colors.deepPurpleAccent : Colors.purple[100]),
        Icon(Icons.star,
            size: 15,
            color:
                (priority >= 5) ? Colors.deepPurpleAccent : Colors.purple[100]),
      ],
    );
  }
}
