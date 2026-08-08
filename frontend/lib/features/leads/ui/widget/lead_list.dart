import 'package:flutter/material.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/features/leads/provider/lead_provider.dart';
import 'package:frontend/shared/widgets/empty_state.dart';
import 'package:frontend/shared/widgets/error_state.dart';
import 'package:frontend/shared/widgets/list_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class LeadList extends StatelessWidget {
  const LeadList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LeadProvider>(
                builder: (context,Provider,child){
                  if(Provider.isLoading){
                    return const CircularProgressIndicator();
                  }
                  else if(Provider.errorMessage!=null){
                    return ErrorState(
                      title: "Error", 
                      errorMessage: "Something went wrong");
                  }
                  else if(Provider.myLeads.isEmpty){
                    return EmptyState(
                      title: "No Leads", 
                      message: "No leads assigned to you"
                      );
                  }
                  return ListWidget(
                    title: "Leads", 
                    items: Provider.myLeads, 
                    column: const[
                      "Lead",
                      "Contact",
                      "Source",
                      "Created At",
                      "Status"
                    ], 
                    columnFlex: const[
                      3,5,3,2,2
                    ],
                    rowBuilder: (lead){
                      return[
                        lead.leadName,
                        lead.phoneNumber!,
                        lead.campaignName!,
                        DateFormat("dd/MM/yyyy").format(lead.addedOn),
                        lead.status
                      ];
                    },
                    onTap: (lead){
                      context.go(AppRoutes.clientLeadInfo);
                    },
                    );

                }
                );
  }
}