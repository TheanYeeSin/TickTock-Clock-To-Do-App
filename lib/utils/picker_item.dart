import 'package:flutter/material.dart';

class PickerItem<T> {
  final T value;
  final Widget displayWidget;

  PickerItem({
    required this.value,
    required this.displayWidget,
  });
}

// AVAILABLE COLORS
List<PickerItem<String>> colors = [
  PickerItem(
    value: '#FF0000',
    displayWidget: Container(color: Colors.red, width: 1, height: 1),
  ),
  PickerItem(
    value: '#0000FF',
    displayWidget: Container(color: Colors.blue, width: 1, height: 1),
  ),
  PickerItem(
    value: '#00FF00',
    displayWidget: Container(
      color: Colors.green,
      width: 1,
      height: 1,
    ),
  ),
];

// AVAILABLE ICONS
List<PickerItem<String>> icons = [
  PickerItem(
    value: 'work',
    displayWidget: const Icon(
      Icons.work,
      size: 30,
    ),
  ),
  PickerItem(
    value: 'sports',
    displayWidget: const Icon(
      Icons.sports,
      size: 30,
    ),
  ),
  PickerItem(
    value: 'knowledge',
    displayWidget: const Icon(
      Icons.book,
      size: 30,
    ),
  ),
];
