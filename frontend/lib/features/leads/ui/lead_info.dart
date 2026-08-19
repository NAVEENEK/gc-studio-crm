import 'package:flutter/material.dart';
import 'package:frontend/features/leads/provider/lead_info_provider.dart';
import 'package:frontend/features/leads/ui/widget/primary_info.dart';
import 'package:frontend/shared/widgets/common_appbar.dart';
import 'package:provider/provider.dart';

class LeadInfo extends StatefulWidget {
  final int leadId;

  const LeadInfo({
    required this.leadId,
    super.key
    });

  @override
  State<LeadInfo> createState() => _LeadInfoState();
}

class _LeadInfoState extends State<LeadInfo> {
  @override
  void initState(){
    super.initState();

    context.read<LeadInfoProvider>().fetchLeadById(widget.leadId);
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

              if(provider.isLoading)
              const CircularProgressIndicator()
              else if(provider.errorMessage != null)
              Text(provider.errorMessage!)
              else if(provider.lead != null)
              PrimaryInfo(
                lead:provider.lead!
                ),
            ],
          ),
        ),
      ),
    );
  }
}
