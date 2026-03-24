import 'package:flutter/material.dart';

Future pickDateTime({
  required BuildContext context,
  DateTime? initialDateTime,
  TimePickerEntryMode initialEntryMode = TimePickerEntryMode.dial,
}) async {
  DateTime initialDate = initialDateTime ?? DateTime.now();
  TimeOfDay initialTime = TimeOfDay.fromDateTime(initialDate);

  //DATE PICKER
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
  );

  if (pickedDate == null) {
    return null;
  }

  //TIME PICKER
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: initialTime,
    initialEntryMode: TimePickerEntryMode.dial,
  );

  if (pickedTime == null) {
    return null;
  }

  DateTime pickedDateTime = DateTime(
    pickedDate.year,
    pickedDate.month,
    pickedDate.day,
    pickedTime.hour,
    pickedTime.minute,
  );

  return pickedDateTime;
}
