import 'package:flutter/material.dart';
import 'package:frontend/features/followups/models/follow_up_model.dart';
import 'package:frontend/features/followups/providers/follow_up_provider.dart';
import 'package:frontend/shared/widgets/empty_state.dart';
import 'package:frontend/shared/widgets/error_state.dart';
import 'package:frontend/shared/widgets/followup_list_card.dart';
import 'package:provider/provider.dart';

class TodayFollowup extends StatelessWidget {

  const TodayFollowup({ super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FollowUpProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.errorMessage != null) {
          return ErrorState(
            title: "Unable to load today's tasks",
            errorMessage:  provider.errorMessage!
            );
        }
        if (provider.todayFollowUps.isEmpty) {
          return EmptyState(
            title: "You're all caught up",
            message: "No follow-ups scheduled for today",
          );
        }
        return FollowupListCard(
          title: "Today's Tasks", 
          followUpList: provider.todayFollowUps, 
          displayType: FollowUpDisplayType.task,
          onViewAll: (){},
          onItemTap: (curentFollow){},
          );
      },
    );
  }
}