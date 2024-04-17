import 'package:flutter/material.dart';
import 'package:tick_tock/models/to_do_item.dart';
import 'package:tick_tock/utils/color.dart';
import 'package:tick_tock/utils/function.dart';
import 'package:intl/intl.dart';
import 'package:tick_tock/widgets/common/custom_divider.dart';

class ReminderTimePicker extends StatelessWidget {
  final String labelText;
  final DateTime? initialDateTime;
  final RepeatOption initialRepeatOption;
  final EdgeInsets? margin;
  final ValueChanged<DateTime> onDateTimeChanged;
  final ValueChanged<RepeatOption> onRepeatOptionChanged;
  final bool readOnly;

  const ReminderTimePicker(
      {super.key,
      required this.labelText,
      this.initialDateTime,
      required this.initialRepeatOption,
      this.margin,
      required this.onDateTimeChanged,
      required this.onRepeatOptionChanged,
      required this.readOnly});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: const EdgeInsets.all(16.0),
            ),
            onPressed: !readOnly
                ? () async {
                    final DateTime? pickedDateTime = await pickDateTime(
                      context: context,
                      initialDateTime: initialDateTime,
                      initialEntryMode: TimePickerEntryMode.dial,
                    );
                    if (pickedDateTime != null) {
                      onDateTimeChanged(pickedDateTime);
                    }
                  }
                : null,
            child: Row(
              children: [
                const Icon(Icons.access_time),
                const SizedBox(width: 8),
                Text(
                  initialDateTime != null
                      ? DateFormat.yMMMMd().add_jm().format(initialDateTime!)
                      : "Add $labelText", // Format the time
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          if (initialDateTime != null)
            Column(
              children: [
                const CustomDivider(
                  symmetricPadding: 0,
                  dividerHeight: 2,
                  dividerThickness: 2,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  child: Row(
                    children: [
                      const Icon(Icons.repeat),
                      const SizedBox(width: 8),
                      const Text(
                        "Repeat",
                        style: TextStyle(fontSize: 16),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: DropdownButton<RepeatOption>(
                            onChanged: !readOnly
                                ? (newValue) {
                                    if (newValue != null) {
                                      onRepeatOptionChanged(newValue);
                                    }
                                  }
                                : null,
                            items: [
                              RepeatOption.never,
                              RepeatOption.everyday,
                              RepeatOption.everyWeek,
                              RepeatOption.everyMonth,
                              RepeatOption.everyYear,
                            ].map((option) {
                              return DropdownMenuItem<RepeatOption>(
                                value: option,
                                child: Text(option.value),
                              );
                            }).toList(),
                            value: initialRepeatOption,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
