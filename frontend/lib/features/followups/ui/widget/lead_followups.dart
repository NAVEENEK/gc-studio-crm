import 'package:flutter/material.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/features/followups/providers/follow_up_provider.dart';
import 'package:frontend/shared/widgets/empty_state.dart';
import 'package:frontend/shared/widgets/error_state.dart';
import 'package:frontend/shared/widgets/list_widget.dart';
import 'package:frontend/shared/widgets/status_indicator.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LeadFollowups extends StatelessWidget {
  final int leadId;

  const LeadFollowups({
    required this.leadId,
    super.key
    });

  

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      elevation: 2,
      child: SizedBox(
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              //header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Follow Ups",
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.go(AppRoutes.clientFollowUps);
                    },
                    child: const Text("View All"),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Expanded(
                child: Consumer<FollowUpProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return const CircularProgressIndicator();
                    }
                    if (provider.errorMessage != null) {
                      return ErrorState(
                        title: "Unable to load follow-ups ",
                        errorMessage: provider.errorMessage!,
                      );
                    }
                    if (provider.leadFollowUps.isEmpty) {
                      return EmptyState(
                        title: "You're all caught up",
                        message: "No follow ups",
                      );
                    }
                    return ListWidget(
                      items: provider.leadFollowUps,
                      column: const ["task", "Follow-up date", "Status"],
                      columnFlex: const [3, 2, 1],
                      rowBuilder: (followUps) {
                        return [
                          followUps.task,
                          DateFormat("dd/MM/yyyy").format(followUps.followUpDate),
                          StatusIndicator(status: followUps.status),
                        ];
                      },
                      onTap: (followups) {
                        context.go(AppRoutes.clientFollowUpsInfo);
                      },
                      maxItems: 5,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
