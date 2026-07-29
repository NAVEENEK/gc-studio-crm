import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/features/dashboard/ui/widgets/quick_action_tile.dart';

class QuickActionSection extends StatelessWidget {
  const QuickActionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600
            ),
            ),

            const SizedBox(height: 24,),

            Row(
              children: [
                Expanded(
                  child: 
                  QuickActionTile(
                    title: "Add Lead", 
                    icon: Icons.person, 
                    onTap: (){

                    }, 
                    color: Colors.blue
                    ),
                  ),
                  const SizedBox(width:  16,),
                  
                  Expanded(child: 
                  QuickActionTile(
                    title: "View Leads", 
                    icon: Icons.list_alt, 
                    onTap: (){

                    }, 
                    color: Colors.blue
                    )
                    ),

                    const SizedBox(width: 16,),

                    Expanded(child: 
                    QuickActionTile(
                    title: "Campaign", 
                    icon: Icons.campaign, 
                    onTap: (){

                    }, 
                    color: Colors.blue
                    )
                    ),

              ],
            )
        ],
      )
    );
  }
}