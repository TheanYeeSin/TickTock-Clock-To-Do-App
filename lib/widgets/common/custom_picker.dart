import 'package:flutter/material.dart';
import 'package:tick_tock/utils/picker_item.dart';

class CustomPicker<T> extends StatefulWidget {
  final List<PickerItem<T>> items;
  final ValueChanged<T> onItemSelected;
  final EdgeInsets? margin;
  final String? initialValue;
  final int crossAxisCount;

  const CustomPicker({
    super.key,
    required this.items,
    required this.onItemSelected,
    this.margin,
    this.initialValue,
    required this.crossAxisCount,
  });

  @override
  State<CustomPicker<T>> createState() => _CustomPickerState<T>();
}

class _CustomPickerState<T> extends State<CustomPicker<T>> {
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      for (int i = 0; i < widget.items.length; i++) {
        if (widget.items[i].value.toString() == widget.initialValue) {
          selectedIndex = i;
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 69,
      width: double.infinity,
      margin: widget.margin,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onItemSelected(widget.items[index].value);
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      selectedIndex == index ? Colors.blue : Colors.transparent,
                  width: 2.0,
                ),
              ),
              child: widget.items[index].displayWidget,
            ),
          );
        },
      ),
    );
  }
}
