import 'package:flutter/material.dart';
import 'package:tick_tock/utils/color.dart';

class CustomTimePicker extends StatelessWidget {
  final String labelText;
  final EdgeInsets? margin;
  final TimeOfDay? initialTime;
  final ValueChanged<TimeOfDay> onTimeChanged;
  final Widget icon;

  const CustomTimePicker({
    super.key,
    required this.labelText,
    this.margin,
    this.initialTime,
    required this.onTimeChanged,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.all(16.0),
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 8),
            Text(
              initialTime != null
                  ? initialTime!.format(context)
                  : labelText, // Format the time
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        onPressed: () async {
          final TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: initialTime ?? TimeOfDay.now(),
            initialEntryMode: TimePickerEntryMode.dial,
          );
          if (pickedTime != null) {
            onTimeChanged(pickedTime);
          }
        },
      ),
    );
  }
}
