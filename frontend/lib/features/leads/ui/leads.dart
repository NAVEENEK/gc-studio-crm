import 'package:flutter/material.dart';
import 'package:frontend/features/leads/provider/lead_provider.dart';
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
                  )
              ],
            )
          ],
        ),
      ),
    ) ;
  }
}