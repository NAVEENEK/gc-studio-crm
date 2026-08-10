import 'package:flutter/material.dart';
import 'package:frontend/features/dashboard/ui/widgets/lead_status_chart.dart';
import 'package:frontend/features/dashboard/ui/widgets/today_followup.dart';
import 'package:frontend/features/leads/provider/lead_status_provider.dart';
import 'package:frontend/shared/widgets/performance_card.dart';
import 'package:frontend/features/dashboard/ui/widgets/quick_action_section.dart';
import 'package:frontend/features/followups/providers/follow_up_provider.dart';
import 'package:frontend/features/leads/provider/lead_provider.dart';
import 'package:provider/provider.dart';

class ClientDashboard extends StatefulWidget {
  const ClientDashboard({super.key});

  @override
  State<ClientDashboard> createState() => _ClientDashboardState();
}

class _ClientDashboardState extends State<ClientDashboard> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FollowUpProvider>().loadTodayFollowUps();
      context.read<LeadStatusProvider>().loadLeadStatusCount();
    });
  }

  @override
  Widget build(BuildContext context) {

    final followUpProvider=context.watch<FollowUpProvider>();

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: PerformanceCard(
                    icon: Icons.ac_unit_outlined,
                    text: "test",
                    color: Colors.amberAccent,

                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: PerformanceCard(
                    icon: Icons.perm_camera_mic_outlined,
                    text: "helo",
                    color: Colors.amberAccent,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: PerformanceCard(
                    icon: Icons.perm_camera_mic_outlined,
                    text: "helo",
                    color: Colors.amberAccent,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: PerformanceCard(
                    icon: Icons.perm_camera_mic_outlined,
                    text: "helo",
                    color: Colors.amberAccent,
                  ),
                ),
              ],
            ),
            const QuickActionSection(),
            const SizedBox(height: 16),
            const TodayFollowup(),
            const SizedBox(height: 10),
            Row(children: [Expanded(child: const LeadStatusChart())]),
          ],
        ),
      ),
    );
  }
}
