import 'package:flutter/material.dart';

class SearchSection extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final List<Widget> filters;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onRefresh;
  final VoidCallback? onClear;

  const SearchSection({
    super.key,
    required this.hintText,
    required this.controller,
    this.filters = const [],
    this.onChanged,
    this.onRefresh,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),

        ...filters,

        if (onRefresh != null) ...[
          const SizedBox(width: 15),
          IconButton(onPressed: onRefresh, icon: const Icon(Icons.refresh)),
        ],
        if (onClear != null) ...[
          const SizedBox(width: 5),
          TextButton(
            onPressed: onClear,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(8),
              ),
            ),
            child: Text("Clear", style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 10),
        ],
      ],
    );
  }
}
