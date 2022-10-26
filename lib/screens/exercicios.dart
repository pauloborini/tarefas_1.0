import 'package:flutter/material.dart';

class Exercicio1 extends StatelessWidget {
  const Exercicio1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(4, 8, 32, 8),
                child: Icon(Icons.add_task_rounded),
              ),
              Text('Flutter: Primeiros Passos'),
            ],
          ),
        ),
        body: Container(
          color: Colors.black12,
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            const Colunas(
              width: 120,
              height: 150,
              color1: Colors.white,
              color2: Colors.pink,
              color3: Colors.pinkAccent,
              color4: Colors.purple,
            ),
            const Colunas(
              width: 120,
              height: 150,
              color1: Colors.pinkAccent,
              color2: Colors.purple,
              color3: Colors.amber,
              color4: Colors.white,
            ),
            Colunas(
              width: 120,
              height: 150,
              color1: Colors.blue.shade300,
              color2: Colors.blueAccent,
              color3: Colors.blue,
              color4: Colors.green,
            ),
          ]),
        ));
  }
}

class Colunas extends StatelessWidget {
  final double width;
  final double height;
  final Color color1;
  final Color color2;
  final Color color3;
  final Color color4;

  const Colunas(
      {super.key,
      required this.width,
      required this.height,
      required this.color1,
      required this.color2,
      required this.color3,
      required this.color4});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: color1,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.black, width: 3)),
          width: width,
          height: height,
          child: const Icon(Icons.people),
        ),
        Container(
          decoration: BoxDecoration(
              color: color2, borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.black, width: 3)),
          width: width,
          height: height,
        ),
        Container(
          decoration: BoxDecoration(
              color: color3, borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.black, width: 3)),
          width: width,
          height: height,
        ),
        Container(
          decoration: BoxDecoration(
              color: color4, borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.black, width: 3)),
          width: width,
          height: height,
        ),
      ],
    );
  }
}
