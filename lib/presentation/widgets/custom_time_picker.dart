import "package:flutter/material.dart";

class CustomTimePicker extends StatelessWidget {
  final String labelText;
  final EdgeInsets? margin;
  final TimeOfDay? initialTime;
  final ValueChanged<TimeOfDay> onTimeChanged;
  final Widget icon;
  final bool readOnly;

  const CustomTimePicker({
    super.key,
    required this.labelText,
    this.margin,
    this.initialTime,
    required this.onTimeChanged,
    required this.icon,
    required this.readOnly,
  });

  @override
  Widget build(final BuildContext context) => Container(
        width: double.infinity,
        margin: margin,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.all(16),
          ),
          onPressed: !readOnly
              ? () async {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: initialTime ?? TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    onTimeChanged(pickedTime);
                  }
                }
              : null,
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
        ),
      );
}
