import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tarefas_game/screens/priority_screen.dart';
import '../screens/initial_screen.dart';
import 'screens/completed_screen.dart';
import 'screens/form_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Tarefas',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Colors.transparent)),
        fontFamily: 'PTSans',
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      initialRoute: "/initial_screen",
      routes: {
        "/initial_screen": (context) =>   InitialScreen(),
        "/priority_screen": (context) =>   PriorityScreen(),
        "/form_screen": (context) => FormScreen(taskContext: context,),
        "/completed_screen": (context) =>   CompletedScreen(),
      },
    );
  }
}
