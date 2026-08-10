import 'package:flutter/material.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/features/followups/providers/follow_up_provider.dart';
import 'package:frontend/shared/widgets/empty_state.dart';
import 'package:frontend/shared/widgets/error_state.dart';
import 'package:frontend/shared/widgets/list_widget.dart';
import 'package:go_router/go_router.dart';
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
        return ListWidget(
          title:  "Today's Tasks", 
          items: provider.todayFollowUps, 
          column: const[
            "Lead",
            "Task",
            "Status"
          ], 
          columnFlex: const [3,5,2],
          rowBuilder: (followups){
            return [
              followups.leadName,
              followups.task,
              followups.status
            ];
          },
          onTap: (followups){
            context.go(AppRoutes.clientFollowUpsInfo);
          },
          );
      },
    );
  }
}