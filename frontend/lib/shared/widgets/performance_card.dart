import 'package:flutter/material.dart';
import 'package:frontend/shared/widgets/icon_container.dart';

class PerformanceCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final double? width;

  const PerformanceCard({
    required this.icon,
    required this.text,
    required this.color,
    this.width=140,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 190,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         IconContainer(
          icon: icon, 
          color: color,
          size: 52,
          borderRadius: 14,
          iconSize: 28,
          ),
          
          const SizedBox(height: 18,),

          Text(
            text,style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 15
            ),
          ),

          //value from db

          const SizedBox( height: 2,),

          Container(
            height: 35,
            width: double.infinity,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8)
            ),
            child: Center(
              child: Text('mini chart'),
            ),
          )


        ],
      ),
    );
  }
}