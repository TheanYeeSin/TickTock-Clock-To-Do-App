import 'package:flutter/material.dart';

class RepeatOption {
  String value;

  RepeatOption(this.value);

  static RepeatOption never = RepeatOption("Never");
  static RepeatOption everyday = RepeatOption("Everyday");
  static RepeatOption everyWeek = RepeatOption("Every Week");
  static RepeatOption everyMonth = RepeatOption("Every Month");
  static RepeatOption everyYear = RepeatOption("Every Year");

  @override
  bool operator ==(Object other) =>
      other is RepeatOption && other.value == value;

  @override
  int get hashCode => value.hashCode;
}

class ToDoItem {
  int? id;
  String title;
  DateTime reminderTime;
  RepeatOption repeatOption;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  bool isImportant;
  int? categoryId;
  String? description;
  bool isCompleted;
  final DateTime createdTime;

  ToDoItem({
    this.id,
    required this.title,
    required this.reminderTime,
    required this.repeatOption,
    this.startTime,
    this.endTime,
    this.isImportant = false,
    this.categoryId,
    this.description,
    this.isCompleted = false,
    required this.createdTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'reminderTime': reminderTime.toIso8601String(),
      'repeatOption': repeatOption.value,
      'startTime':
          startTime != null ? '${startTime!.hour}:${startTime!.minute}' : null,
      'endTime': endTime != null ? '${endTime!.hour}:${endTime!.minute}' : null,
      'isImportant': isImportant ? 1 : 0,
      'categoryId': categoryId,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
      'createdTime': createdTime.toIso8601String(),
    };
  }

  factory ToDoItem.fromMap(Map<String, dynamic> map) {
    return ToDoItem(
      id: map['id'],
      title: map['title'],
      reminderTime: DateTime.parse(map['reminderTime']),
      repeatOption: RepeatOption(map['repeatOption']),
      startTime:
          map['startTime'] != null ? _parseTimeOfDay(map['startTime']) : null,
      endTime: map['endTime'] != null ? _parseTimeOfDay(map['endTime']) : null,
      isImportant: map['isImportant'] == 1,
      categoryId: map['categoryId'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1,
      createdTime: DateTime.parse(map['createdTime']),
    );
  }

  static TimeOfDay _parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
