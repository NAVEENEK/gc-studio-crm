import 'package:flutter/material.dart';
import 'package:frontend/shared/widgets/icon_container.dart';

class QuickActionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const QuickActionTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.color,
    });

  @override
  Widget build(BuildContext context) {
    return  Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(vertical: 16),
        child: Column(
          children: [
            IconContainer(
              icon: icon, 
              color: color,
              size: 64,
              borderRadius: 22,
              iconSize: 32,
              ),
            const SizedBox(height: 12,),

            Text(
              title,
              textAlign: TextAlign.center,
            )

          ],
        ),
        ),
    ),
    );
  }
}