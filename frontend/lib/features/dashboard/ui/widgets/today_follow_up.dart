import 'package:flutter/material.dart';
import 'package:frontend/features/followups/models/follow_up_model.dart';

class TodayFollowUp extends StatelessWidget {
  final List<FollowUpModel> followUps;

  const TodayFollowUp({required this.followUps, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today Task",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "view all",
                  style: TextStyle(
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(flex: 3, child: Text("Lead")),

              Expanded(flex: 5, child: Text("Task")),
              Expanded(flex: 2, child: Text("Status")),
            ],
          ),
          Divider(height: 24, thickness: 1, color: Colors.grey.shade300),

          Expanded(
            child: ListView.builder(
              itemCount: followUps.length,
              itemBuilder: (context, index) {
                final followUp = followUps[index];
                return Row(
                  children: [
                    Expanded(flex: 3, child: Text(followUp.leadName)),
                    Expanded(flex: 5, child: Text(followUp.task)),
                    Expanded(flex: 2, child: Text(followUp.status)),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
