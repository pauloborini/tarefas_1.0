import 'package:flutter/material.dart';
import '../screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Tarefas',
      theme: ThemeData(
        fontFamily: 'PTSans',
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}
