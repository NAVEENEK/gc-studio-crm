import 'package:flutter/material.dart';
import 'package:frontend/features/followups/providers/follow_up_provider.dart';
import 'package:frontend/features/followups/ui/widget/lead_followups.dart';
import 'package:frontend/features/leads/provider/lead_info_provider.dart';
import 'package:frontend/features/leads/ui/widget/quick_action_lead.dart';
import 'package:frontend/features/notes/widget/notes_card.dart';
import 'package:frontend/features/leads/ui/widget/primary_info.dart';
import 'package:frontend/shared/widgets/common_appbar.dart';
import 'package:provider/provider.dart';

class LeadInfo extends StatefulWidget {
  final int leadId;

  const LeadInfo({required this.leadId, super.key});

  @override
  State<LeadInfo> createState() => _LeadInfoState();
}

class _LeadInfoState extends State<LeadInfo> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LeadInfoProvider>().fetchLeadById(widget.leadId);
      context.read<FollowUpProvider>().loadFollowUpsById(widget.leadId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LeadInfoProvider>();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const CommonAppbar(title: "Lead Details"),

              if (provider.isLoading)
                const CircularProgressIndicator()
              else if (provider.errorMessage != null)
                Text(provider.errorMessage!)
              else if (provider.lead != null) ...[
                PrimaryInfo(lead: provider.lead!),

                const SizedBox(height: 10),
                QuickActionLead(
                  leadId: provider.lead!.leadId,
                  leadName: provider.lead!.leadName,
                ),

                Row(
                  children: [
                    Expanded(child: NotesCard(leadId: widget.leadId)),
                    const SizedBox(width: 20),
                    Expanded(child: LeadFollowups(leadId: widget.leadId)),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
