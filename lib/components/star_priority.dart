import 'package:flutter/material.dart';

class Priority extends StatelessWidget {
  final int priority;
  final Color stanColor = const Color.fromARGB(255, 245, 244, 240);
  final Color purple = const Color.fromARGB(255, 127, 89, 206);

  const Priority(this.priority, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star,
            size: 15,
            color:
                (priority >= 1) ? purple : Colors.purple[100]),
        Icon(Icons.star,
            size: 15,
            color:
                (priority >= 2) ? purple : Colors.purple[100]),
        Icon(Icons.star,
            size: 15,
            color:
                (priority >= 3) ? purple : Colors.purple[100]),
        Icon(Icons.star,
            size: 15,
            color:
                (priority >= 4) ? purple : Colors.purple[100]),
        Icon(Icons.star,
            size: 15,
            color:
                (priority >= 5) ? purple : Colors.purple[100]),
      ],
    );
  }
}
