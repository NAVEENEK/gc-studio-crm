import 'package:flutter/material.dart';

class BuildDropdown extends StatelessWidget {
  final String label;
  final String hint;
  final List<DropdownMenuItem<String>> items;

  const BuildDropdown({
    required this.label,
    required this.hint,
    required this.items,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
      ),
      const SizedBox(height: 8),
      DropdownButtonFormField<String>(
        hint: Text(hint),
        items: items,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 16,
          ),
        ),
        borderRadius: BorderRadius.circular(14),
        onChanged: (value) {},
      ),
    ],
  );;
  }
}
