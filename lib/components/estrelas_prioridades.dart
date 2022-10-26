import 'package:flutter/material.dart';

class Prioridade extends StatelessWidget {
  final int prioridade;

  const Prioridade(this.prioridade, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star,
            size: 15,
            color: (prioridade >= 1) ? Colors.deepPurpleAccent : Colors.purple[100]),
        Icon(Icons.star,
            size: 15,
            color: (prioridade >= 2) ? Colors.deepPurpleAccent : Colors.purple[100]),
        Icon(Icons.star,
            size: 15,
            color: (prioridade >= 3) ? Colors.deepPurpleAccent : Colors.purple[100]),
        Icon(Icons.star,
            size: 15,
            color: (prioridade >= 4) ? Colors.deepPurpleAccent : Colors.purple[100]),
        Icon(Icons.star,
            size: 15,
            color: (prioridade >= 5) ? Colors.deepPurpleAccent : Colors.purple[100]),
      ],
    );
  }
}
