import 'package:flutter/material.dart';

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
    return  InkWell(
      onTap: onTap,
      hoverColor: Colors.blueGrey,
      borderRadius: BorderRadius.circular(10),
      child:Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 12
        ),
        decoration: BoxDecoration(
          color: isSelected
          ? Colors.blue
          :Colors.transparent,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          
          children: [
            Icon(
              icon,
              color:Colors.white ,
            ),
            if(!isCollapsed)...[
              const SizedBox(width: 15,),
              Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16
              ),
              )
            ]
            
          ],
        ),
      ) 
      
    );
  }
}