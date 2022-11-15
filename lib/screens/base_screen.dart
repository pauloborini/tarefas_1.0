import 'package:flutter/material.dart';
import 'package:tarefas_game/screens/completed_screen.dart';
import '../components/utilities/colors_and_vars.dart';
import 'list_screen.dart';
import 'profile_screen.dart';

class InitialScreen extends StatefulWidget {
   InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List body = [
      ListScreen(),
      CompletedScreen(),
      ProfileScreen(),
    ];
    return Scaffold(
      body: body.elementAt(currentIndex),
      bottomNavigationBar: Container(
        color: stanColor,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(24), topLeft: Radius.circular(24)),
          child: BottomNavigationBar(
            backgroundColor: stanColor,
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.access_alarm, color: iconColor),
                  label: 'Para fazer',
                  backgroundColor: tabColorOrange),
              BottomNavigationBarItem(
                icon: Icon(Icons.task_alt, color: iconColor),
                label: 'Completadas',
                backgroundColor: tabColorGreen,
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person, color: iconColor),
                  label: 'Perfil',
                  backgroundColor: tabColorBlue),
            ],
          ),
        ),
      ),
    );
  }
}
