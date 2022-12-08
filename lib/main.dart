import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tarefas_game/components/utilities/colors_and_vars.dart';

import '../screens/base_screen.dart';
import 'components/utilities/functions.dart';
import 'screens/completed_screen.dart';
import 'screens/form_screen.dart';
import 'screens/list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Tarefas',
      theme: ThemeData(
        // textButtonTheme: const TextButtonThemeData(style: ButtonStyle()),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: StadiumBorder(),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            showUnselectedLabels: false,
            elevation: 0,
            type: BottomNavigationBarType.shifting,
            selectedItemColor: fontColor),
        appBarTheme: const AppBarTheme(
            scrolledUnderElevation: 0,
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Colors.transparent)),
        fontFamily: 'PTSans',
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      initialRoute: "/initial_screen",
      routes: {
        "/initial_screen": (context) => InitialScreen(),
        "/list_screen": (context) => ListScreen(),
        "/form_screen": (context) => FormScreen(
              taskContext: context,
            ),
        "/completed_screen": (context) => CompletedScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
