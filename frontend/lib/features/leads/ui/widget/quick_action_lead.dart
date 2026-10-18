import 'package:flutter/material.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/shared/widgets/quick_action_tile.dart';
import 'package:go_router/go_router.dart';

class QuickActionLead extends StatelessWidget {
  final int leadId;
  final String leadName;
  const QuickActionLead({super.key,
  required this.leadId,
  required this.leadName});

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
      child:  Column(
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
                    title: "Add Notes", 
                    icon: Icons.note_add_outlined, 
                    onTap: (){
                      context.push(
                        AppRoutes.clientAddNotes,
                        extra: {
                          'leadId':leadId
                        }
                      );
                    }, 
                    color: Colors.blue
                    ),
                  ),
                  const SizedBox(width:  16,),
                  
                  Expanded(child: 
                  QuickActionTile(
                    title: "Add Follow Up", 
                    icon: Icons.add_alarm_outlined, 
                    onTap: (){
                      context.push(
                        AppRoutes.clientAddFollowUps,
                        extra:{
                          'leadId':leadId,
                          'leadName':leadName
                        }
                      );
                    }, 
                    color: Colors.blue
                    )
                    ),

                    const SizedBox(width: 16,),

                    Expanded(child: 
                    QuickActionTile(
                    title: "Status", 
                    icon: Icons.sync_alt_outlined, 
                    onTap: (){

                    }, 
                    color: Colors.blue
                    )
                    ),

              ],
            )
        ],
      ),
    );
  }
}