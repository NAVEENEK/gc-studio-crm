import 'package:flutter/material.dart';

class SearchDropdown<T>extends StatelessWidget {
  final T? value;
  final String hint;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final double width;
  final String? Function(T?)? validator;

  const SearchDropdown({
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    this.width=170,
    this.validator,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: DropdownButtonFormField(
        initialValue: value,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12,
          vertical: 14
          )
        ),
        items: items, 
        onChanged: onChanged
        ),
    );
  }
}