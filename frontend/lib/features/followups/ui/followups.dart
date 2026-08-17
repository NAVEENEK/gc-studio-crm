import 'package:flutter/material.dart';
import 'package:frontend/features/followups/providers/follow_up_provider.dart';
import 'package:frontend/features/followups/ui/widget/my_followup.dart';
import 'package:frontend/shared/widgets/performance_card.dart';
import 'package:frontend/shared/widgets/search_dropdown.dart';
import 'package:frontend/shared/widgets/search_section.dart';
import 'package:provider/provider.dart';

class FollowUps extends StatefulWidget {
  const FollowUps({super.key});

  @override
  State<FollowUps> createState() => _FollowUpsState();
}

class _FollowUpsState extends State<FollowUps> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final followUpProvider = context.watch<FollowUpProvider>();

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Wrap(
              spacing: 15,
              runSpacing: 15,
              children: [
                PerformanceCard(
                  icon: Icons.calendar_month_outlined,
                  text: "Today's Task",
                  color: Colors.blue,
                  width: 250,
                ),
                PerformanceCard(
                  icon: Icons.lock_clock_outlined,
                  text: "Pending",
                  color: Colors.yellow,
                  width: 250,
                ),
                PerformanceCard(
                  icon: Icons.done_all,
                  text: "Completed",
                  color: Colors.green,
                  width: 250,
                ),
                PerformanceCard(
                  icon: Icons.cancel_outlined,
                  text: "Cancel",
                  color: Colors.black,
                  width: 250,
                ),
                PerformanceCard(
                  icon: Icons.warning_amber_outlined,
                  text: "Overdue",
                  color: Colors.red,
                  width: 250,
                ),
              ],
            ),
            const SizedBox(height: 8),
            SearchSection(
              hintText: "search by Lead",
              controller: _searchController,
              onChanged: (value) {
                followUpProvider.loadMyFollowUps(search: value);
              },
              onClear: (){
                _searchController.clear();
                context.read<FollowUpProvider>().clearFilters();
              },
              filters: [
                SearchDropdown(
                  hint: "Status",
                  value: followUpProvider.selectedStatus,
                  items: const [
                    DropdownMenuItem(value: "pending", child: Text("Pending")),
                    DropdownMenuItem(
                      value: "completed",
                      child: Text("Completed"),
                    ),
                    DropdownMenuItem(
                      value: "cancelled",
                      child: Text("Cancelled"),
                    ),
                  ],
                  onChanged: (value) {
                    followUpProvider.loadMyFollowUps(status: value);
                  },
                ),
                SearchDropdown(
                  hint: "Date",
                  value: followUpProvider.selectedFilter,
                  items: const [
                    DropdownMenuItem(value: "today", child: Text("Today")),
                    DropdownMenuItem(value: "overdue", child: Text("Overdue")),
                  ],
                  onChanged: (value) {
                    followUpProvider.loadMyFollowUps(filter: value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            const MyFollowUps(),
          ],
        ),
      ),
    );
  }
}
