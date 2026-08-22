import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/leads/provider/lead_status_provider.dart';
import 'package:frontend/shared/widgets/empty_state.dart';
import 'package:frontend/shared/widgets/error_state.dart';
import 'package:provider/provider.dart';

class LeadStatusChart extends StatelessWidget {
  const LeadStatusChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Lead Status Overview",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Consumer<LeadStatusProvider>(
            builder: (context, provider, child) {
              // Loading state
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              // Error state
              if (provider.errorMessage != null) {
                return ErrorState(
                  title: "Somethig Went wrong",
                  errorMessage: "Unable to load chart",
                );
              }

              if (provider.leadStatus.isEmpty) {
                return EmptyState(
                  title: "No Leads",
                  message: "No lead assigned to you",
                );
              }

              // Main content
              return Expanded(
                child: Row(
                  children: [
                    // Pie Chart
                    Expanded(
                      child: PieChart(
                        PieChartData(
                          sections: provider.leadStatus.map((status) {
                            return PieChartSectionData(
                              value: status.count.toDouble(),
                              title: status.count.toString(),
                              radius: 60,
                              titleStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          }).toList(),
                          centerSpaceRadius: 45,
                          sectionsSpace: 2,
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),

                    // Status List
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: provider.leadStatus.map((status) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                ),

                                const SizedBox(width: 8),

                                Expanded(child: Text(status.status)),

                                Text(
                                  status.count.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
