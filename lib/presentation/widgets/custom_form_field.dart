import 'package:flutter/material.dart';
import 'package:tick_tock/utils/validator.dart';

class CustomFormField<T> extends StatelessWidget {
  final TextEditingController? controller;
  final int? maxLines;
  final String hintText;
  final String errorText;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final CustomValidator<T>? validator;
  final EdgeInsets? margin;
  final bool readOnly;

  const CustomFormField({
    super.key,
    this.controller,
    this.maxLines,
    required this.hintText,
    required this.errorText,
    required this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.margin,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextFormField(
        readOnly: readOnly,
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(start: 8.0),
            child: prefixIcon,
          ),
          hintText: hintText,
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(width: 1, color: Colors.blue),
          ),
        ),
        validator: (value) => validator?.call(value as T, errorText),
      ),
    );
  }
}
