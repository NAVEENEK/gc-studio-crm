import 'package:flutter/material.dart';
import 'package:frontend/features/followups/models/follow_up_model.dart';
import 'package:frontend/features/followups/providers/follow_up_provider.dart';
import 'package:provider/provider.dart';

class TodayFollowUp extends StatelessWidget {

  const TodayFollowUp({ super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FollowUpProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.errorMessage != null) {
          return _ErrorWidget(provider.errorMessage!);
        }
        if (provider.todayFollowUps.isEmpty) {
          return _EmptyWidget();
        }
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
                  itemCount: provider.todayFollowUps.length,
                  itemBuilder: (context, index) {
                    final followUp = provider.todayFollowUps[index];
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
      },
    );
  }
}

Widget _ErrorWidget(String errorMessage){
  return Container(
    height: 230,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius:BorderRadius.circular(20) 
    ),
    child:  Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.cloud_off_outlined,
            color: Colors.redAccent,
            size: 48,
          ),
          const SizedBox(height: 12,),
          Text(
            "Unable to load today's task",
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 4,),
          Text(
            errorMessage,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  );
}

Widget _EmptyWidget(){
  return Container(
    height: 230,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20)
    ),
    child: const Center(
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
            "You're all caught up",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          ),
          const SizedBox(height: 4,),
          Text(
            "No follow-ups scheduled for today",
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    ),
  );
}