import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tick_tock/models/to_do_item.dart';
import 'package:tick_tock/utils/validator.dart';
import 'package:tick_tock/widgets/common/custom_boolean_field.dart';
import 'package:tick_tock/widgets/common/custom_form_field.dart';
import 'package:tick_tock/widgets/common/custom_time_picker.dart';
import 'package:tick_tock/widgets/common/reminder_time_picker.dart';

class ToDoForm extends StatefulWidget {
  final ToDoItem? toDoItem;

  const ToDoForm({super.key, this.toDoItem});

  @override
  State<ToDoForm> createState() => _ToDoFormState();
}

class _ToDoFormState extends State<ToDoForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late ValueNotifier<bool?> _isImportantController;
  late ValueNotifier<DateTime?> _reminderTimeController;
  late ValueNotifier<RepeatOption?> _repeatOptionController;
  late ValueNotifier<TimeOfDay?> _startTimeController;
  late ValueNotifier<TimeOfDay?> _endTimeController;

  @override
  void initState() {
    super.initState();
    _isImportantController = ValueNotifier<bool?>(false);
    _reminderTimeController = ValueNotifier<DateTime?>(null);
    _startTimeController = ValueNotifier<TimeOfDay?>(null);
    _endTimeController = ValueNotifier<TimeOfDay?>(null);
    _repeatOptionController = ValueNotifier<RepeatOption?>(RepeatOption.never);
  }

  bool _isTimeRangeValid() {
    if (_startTimeController.value != null &&
        _endTimeController.value != null) {
      final startTime = _startTimeController.value!;
      final endTime = _endTimeController.value!;
      return startTime.hour < endTime.hour ||
          (startTime.hour == endTime.hour && startTime.minute < endTime.minute);
    }
    return true;
  }

  bool _validateTimeRange() {
    if (!_isTimeRangeValid()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Invalid Time Range"),
            content: const Text("End time must be greater than start time."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //TITLE
              CustomFormField(
                controller: _titleController,
                hintText: "Title",
                errorText: "Required",
                prefixIcon: const Icon(Icons.document_scanner),
                validator: requiredString,
                margin: const EdgeInsets.only(bottom: 16),
                readOnly: false,
              ),
              //REMINDER DATETIME PICKER
              ReminderTimePicker(
                labelText: "Reminder",
                initialDateTime: _reminderTimeController.value,
                initialRepeatOption: _repeatOptionController.value,
                margin: const EdgeInsets.only(bottom: 16),
                onDateTimeChanged: (newTime) {
                  setState(() {
                    _reminderTimeController.value = newTime;
                  });
                },
                onRepeatOptionChanged: (newValue) {
                  setState(() {
                    _repeatOptionController.value = newValue;
                  });
                },
              ),
              //START TIME PICKER
              Row(
                children: [
                  Expanded(
                    child: CustomTimePicker(
                      labelText: "Start",
                      margin: const EdgeInsets.only(bottom: 16),
                      initialTime: _startTimeController.value,
                      icon: const Icon(Icons.start),
                      onTimeChanged: (newTime) {
                        setState(() {
                          _startTimeController.value = newTime;
                        });
                        if (!_validateTimeRange()) {
                          _startTimeController.value = null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  //END TIME PICKER
                  Expanded(
                    child: CustomTimePicker(
                      labelText: "End",
                      margin: const EdgeInsets.only(bottom: 16),
                      initialTime: _endTimeController.value,
                      icon: const Icon(Icons.stop),
                      onTimeChanged: (newTime) {
                        setState(() {
                          _endTimeController.value = newTime;
                        });
                        if (!_validateTimeRange()) {
                          setState(() {
                            _endTimeController.value = null;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              //IS IMPORTANT
              CustomBooleanField(
                labelText: "Mark as Important",
                prefixIcon: const Icon(
                  Icons.priority_high_rounded,
                  color: Colors.red,
                ),
                margin: const EdgeInsets.only(bottom: 16),
                onChanged: (newBool) {
                  setState(() {
                    _isImportantController.value = newBool;
                  });
                },
              ),
              //DESCRIPTION
              CustomFormField(
                controller: _descriptionController,
                hintText: "Description",
                errorText: "Required",
                prefixIcon: const Icon(Icons.description),
                maxLines: 3,
                margin: const EdgeInsets.only(bottom: 16),
                readOnly: false,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.check),
      ),
    );
  }
}
