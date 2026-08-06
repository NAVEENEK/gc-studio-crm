import 'package:flutter/material.dart';
import 'package:frontend/features/followups/providers/follow_up_provider.dart';
import 'package:frontend/shared/widgets/empty_state.dart';
import 'package:frontend/shared/widgets/error_state.dart';
import 'package:frontend/shared/widgets/followup_list_card.dart';
import 'package:provider/provider.dart';

class UpcomingFollowups extends StatelessWidget {
  const UpcomingFollowups({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FollowUpProvider>(
      builder: (context,provider,child){
        if(provider.isLoading){
          return const CircularProgressIndicator();
        }
        if(provider.errorMessage != null){
          return ErrorState(
            title: "Unable to load follow-ups ", 
            errorMessage: provider.errorMessage!
            );
        }
        if(provider.myFollowUps.isEmpty){
          return EmptyState(
            title: "You're all caught up", 
            message: "No follow ups"
            );
        }
        return FollowupListCard(
          title: "Upcoming Follow-ups", 
          followUpList: provider.myFollowUps, 
          displayType: FollowUpDisplayType.followUpDate,
          onViewAll: (){},
          onItemTap: (curre){},
          );
      }
      );
  }
}