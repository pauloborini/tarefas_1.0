import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  const AdaptativeDatePicker(
      {Key? key, required this.selectedDate, required this.onDateChanged})
      : super(key: key);

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2023),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      onDateChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Container(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime.now(),
              maximumDate: DateTime(2023),
              onDateTimeChanged: onDateChanged,
            ),
          )
        : Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      selectedDate == null
                          ? 'Sem data selecionada'
                          : DateFormat('dd/MM/y').format(selectedDate),
                      style: (const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                ),
                TextButton(
                  onPressed: () => _showDatePicker(context),
                  child: const Text(
                    'Selecionar data',
                    style: (TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          );
  }
}
