import 'package:flutter/material.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/features/followups/providers/follow_up_provider.dart';
import 'package:frontend/shared/widgets/empty_state.dart';
import 'package:frontend/shared/widgets/error_state.dart';
import 'package:frontend/shared/widgets/list_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
        return ListWidget(
          title: "Upcoming Follow-ups", 
          items: provider.myFollowUps, 
          column: const[
            "Lead",
            "Follow-up date",
            "Status"
          ], 
          columnFlex: const [3,2,2],
          rowBuilder: (followUps){
            return[
              followUps.leadName,
              DateFormat("dd/MM/yyyy").format(followUps.followUpDate),
            ];
          },
          onTap: (followups){
            context.go(AppRoutes.clientFollowUpsInfo);
          },
          maxItems: 5,
          showViewAll: true,
          onViewAll: (){
            context.go(AppRoutes.clientFollowUps);
          },
          );
      }
      );
  }
}

        