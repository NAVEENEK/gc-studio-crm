import 'package:flutter/material.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/features/followups/providers/follow_up_provider.dart';
import 'package:frontend/shared/widgets/empty_state.dart';
import 'package:frontend/shared/widgets/error_state.dart';
import 'package:frontend/shared/widgets/list_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyFollowUps extends StatelessWidget {
  const MyFollowUps({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      elevation: 2,
      child: SizedBox(
        height: 280,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              //header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Follow-Ups",
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Expanded(
                child: Consumer<FollowUpProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return const CircularProgressIndicator();
                    } else if (provider.errorMessage != null) {
                      return ErrorState(
                        title: "Error",
                        errorMessage: "Somethig went wrong",
                      );
                    } else if (provider.myFollowUps.isEmpty) {
                      return EmptyState(
                        title: "No Follow-ups",
                        message: "No follow ups scheduled ",
                      );
                    }
                    return ListWidget(
                      items: provider.myFollowUps,
                      column: const ["Lead", "Task", "Follow-up Date", "status"],
                      columnFlex: const [3, 4, 2, 2],
                
                      rowBuilder: (followUps) {
                        return [
                          followUps.leadName,
                          followUps.task,
                          DateFormat("dd/MM/yyyy").format(followUps.followUpDate),
                          followUps.status,
                        ];
                      },
                      onTap: (followUps) {
                        context.go(AppRoutes.clientFollowUpsInfo);
                      },
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
