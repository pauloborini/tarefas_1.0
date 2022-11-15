import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'utilities/colors_and_vars.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String label;
  final AppBar appBar;
  final Function() opacityFunc;
  final Widget orderBy;

  final List<Widget>? widgets;

  const BaseAppBar({
    super.key,
    required this.label,
    required this.appBar,
    required this.opacityFunc,
    required this.orderBy,
    this.widgets,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      toolbarHeight: 140,
      backgroundColor: stanColor,
      elevation: 0,
      title: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Stack(children: [
              Container(
                alignment: Alignment.topRight,
                width: double.infinity,
                child: InkWell(
                    onTap: opacityFunc,
                    child: const SizedBox(
                        width: 50,
                        child: Icon(Icons.remove_red_eye, color: purple))),
              ),
              const Center(
                child: Text(
                  'Olá!',
                  style: TextStyle(
                      color: fontColor,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24), color: orange),
              child: Center(
                child: Text(
                    'Tenha um ótimo ${DateFormat('d MMM y').format(DateTime.now())}!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Rubik',
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                orderBy,
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(140);
}
