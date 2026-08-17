import 'package:flutter/material.dart';
import 'package:frontend/features/leads/ui/widget/primary_info.dart';
import 'package:frontend/shared/widgets/common_appbar.dart';

class LeadInfo extends StatelessWidget {
  const LeadInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const CommonAppbar(title: "Lead Details"),
              PrimaryInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
