import 'package:flutter/material.dart';
import 'package:frontend/features/leads/provider/lead_provider.dart';
import 'package:frontend/features/leads/ui/widget/search_section.dart';
import 'package:frontend/shared/widgets/performance_card.dart';
import 'package:frontend/shared/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class Leads extends StatelessWidget {
  const Leads({super.key});

  @override
  Widget build(BuildContext context) {
    final leadProvider=context.watch<LeadProvider>();
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Leads",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Text(
                      "Track and manage all your leads in one place",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal
                      ),
                    )
                  ], 
                ),

                PrimaryButton(
                  text: "add lead",
                  icon: Icons.add, 
                  onPressed: (){}, 
                  isLoading: leadProvider.isLoading, 
                  backgroundColor: Colors.blue
                  ),
                  
              ],
            ),
            const SizedBox(height: 10,),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                PerformanceCard(
                  icon: Icons.people_alt_outlined, 
                  text: "Totol Leads", 
                  color: Colors.blue
                  ),
                  PerformanceCard(
                    icon: Icons.table_restaurant_outlined, 
                    text: "New Leads", 
                    color: const Color.fromARGB(255, 13, 65, 15)
                    ),
                    PerformanceCard(icon: Icons.high_quality_outlined, text: "Assigned", color: Colors.black),
                    PerformanceCard(icon: Icons.lock_clock_outlined, text: "Contacted", color: Colors.yellow),
                    PerformanceCard(icon: Icons.join_full, text: "Qualified", color: const Color.fromARGB(255, 244, 54, 200)),
                    PerformanceCard(icon: Icons.park_rounded, text: "Praposal send", color: Colors.blueGrey),
                    PerformanceCard(icon: Icons.ac_unit_rounded, text: "Negotiation", color: const Color.fromARGB(255, 107, 216, 240)),
                    PerformanceCard(icon: Icons.access_alarm_outlined, text: "Won", color: Colors.green),
                    PerformanceCard(icon: Icons.tab_unselected_outlined, text: "Lost", color: Colors.red),
                    
              ],
            ),
            const SizedBox(height: 10,),
            SearchSection()
          ],
        ),
      ),
    ) ;
  }
}