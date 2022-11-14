import 'package:flutter/material.dart';

class Priority extends StatelessWidget {
  final int priority;
  final Color stanColor = const Color.fromARGB(255, 245, 244, 240);
  final Color purple = const Color.fromARGB(255, 127, 89, 206);
  final Color? starFilled = Colors.purple[100];
  final Color? starEmpty = Colors.purple[800];

   Priority({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star,
            size: 15,
            color:
                (priority >= 1) ? starFilled  : starEmpty),
        Icon(Icons.star,
            size: 15,
            color:
                (priority >= 2) ? starFilled : starEmpty),
        Icon(Icons.star,
            size: 15,
            color:
                (priority >= 3) ? starFilled : starEmpty),
        Icon(Icons.star,
            size: 15,
            color:
                (priority >= 4) ? starFilled : starEmpty),
        Icon(Icons.star,
            size: 15,
            color:
                (priority >= 5) ? starFilled : starEmpty),
      ],
    );
  }
}
