import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isCollapsed;
  final bool isSelected;
  final VoidCallback onTap;
  
  const MenuItem({
    required this.icon,
    required this.title,
    required this.isCollapsed,
    required this.isSelected,
    required this.onTap,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return  Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        hoverColor: AppColors.primary.withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(10),
        child:Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 12
          ),
          decoration: BoxDecoration(
            color: isSelected
            ? AppColors.primary
            :Colors.transparent,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            
            children: [
              Icon(
                icon,
                color: isSelected 
                ? Colors.white
                :Colors.black,
              ),
              if(!isCollapsed)...[
                const SizedBox(width: 15,),
                Text(
                title,
                style:  TextStyle(
                  color:isSelected 
                  ? Colors.white 
                  : Colors.black,
                  fontSize: 16
                ),
                )
              ]
              
            ],
          ),
        ) 
        
      ),
    );
  }
}