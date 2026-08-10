import 'package:flutter/material.dart';

class SearchSection extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final List<Widget> filters;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onRefresh;

  const SearchSection({
    super.key,
    required this.hintText,
    required this.controller,
    this.filters = const [],
    this.onChanged,
    this.onRefresh,
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
      ],
    );
  }
}
