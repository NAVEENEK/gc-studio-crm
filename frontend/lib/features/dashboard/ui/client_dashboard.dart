import 'package:flutter/material.dart';
import 'package:frontend/features/dashboard/ui/widgets/performance_card.dart';
import 'package:frontend/features/dashboard/ui/widgets/quick_action_section.dart';

class ClientDashboard extends StatefulWidget {
  const ClientDashboard({super.key});

  @override
  State<ClientDashboard> createState() => _ClientDashboardState();
}

class _ClientDashboardState extends State<ClientDashboard> {
  @override
  Widget build(BuildContext context) {
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
                const SizedBox(height: 20),
                Expanded(
                  child: PerformanceCard(
                    icon: Icons.perm_camera_mic_outlined,
                    text: "helo",
                    color: Colors.amberAccent,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: PerformanceCard(
                    icon: Icons.perm_camera_mic_outlined,
                    text: "helo",
                    color: Colors.amberAccent,
                  ),
                ),
                const SizedBox(height: 20),
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
          ],
        ),
      ),
    );
  }
}
