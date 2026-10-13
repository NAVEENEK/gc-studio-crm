import 'package:flutter/material.dart';

class AppTextfield extends StatelessWidget {
  final String label;
  final String? hint;
  final int? maxLines;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const AppTextfield({
    super.key,
    required this.label,
    this.hint,
    this.maxLines,
    this.controller,
    this.validator
    });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines:maxLines ,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder()
      ),
    );
  }
}
