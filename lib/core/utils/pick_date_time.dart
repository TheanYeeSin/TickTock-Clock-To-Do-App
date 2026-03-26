import "package:flutter/material.dart";

Future pickDateTime({
  required final BuildContext context,
  final DateTime? initialDateTime,
  final TimePickerEntryMode initialEntryMode = TimePickerEntryMode.dial,
}) async {
  final DateTime initialDate = initialDateTime ?? DateTime.now();
  final TimeOfDay initialTime = TimeOfDay.fromDateTime(initialDate);

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
  );

  if (pickedTime == null) {
    return null;
  }

  final DateTime pickedDateTime = DateTime(
    pickedDate.year,
    pickedDate.month,
    pickedDate.day,
    pickedTime.hour,
    pickedTime.minute,
  );

  return pickedDateTime;
}
