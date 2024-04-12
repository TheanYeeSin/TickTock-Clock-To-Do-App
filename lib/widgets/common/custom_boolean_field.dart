import 'package:flutter/material.dart';
import 'package:tick_tock/utils/color.dart';

class CustomBooleanField extends StatefulWidget {
  final String labelText;
  final bool? initialBool;
  final Widget prefixIcon;
  final EdgeInsets? margin;
  final ValueChanged<bool> onChanged;

  const CustomBooleanField({
    super.key,
    required this.labelText,
    this.initialBool,
    required this.prefixIcon,
    this.margin,
    required this.onChanged,
  });

  @override
  State<CustomBooleanField> createState() => _CustomBooleanFieldState();
}

class _CustomBooleanFieldState extends State<CustomBooleanField> {
  late bool _value;

  @override
  void initState() {
    _value = widget.initialBool ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          widget.prefixIcon,
          const SizedBox(width: 8),
          Text(
            widget.labelText,
            style: const TextStyle(fontSize: 16),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Switch(
                value: _value,
                onChanged: (newValue) {
                  setState(() {
                    _value = newValue;
                  });
                  widget.onChanged(newValue);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
