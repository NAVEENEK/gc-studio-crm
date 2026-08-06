import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String message;

  const EmptyState({
    required this.title,
    required this.message,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return Container(
    height: 230,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20)
    ),
    child:  Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.event_available_outlined,
            size: 48,
            color: Colors.grey,
          ),
          const SizedBox(height: 12,),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          ),
          const SizedBox(height: 4,),
          Text(
            message,
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    ),
  );
}
  }
