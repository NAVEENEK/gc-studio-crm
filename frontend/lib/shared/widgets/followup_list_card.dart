import 'package:flutter/material.dart';
import 'package:frontend/features/followups/models/follow_up_model.dart';

enum FollowUpDisplayType { task, followUpDate }

class FollowupListCard extends StatelessWidget {
  final String title;
  final List<FollowUpModel> followUpList;
  final FollowUpDisplayType displayType;
  final int? maxItems;
  final VoidCallback? onViewAll;
  final void Function(FollowUpModel selectedFollowUp)? onItemTap;

  const FollowupListCard({
    required this.title,
    required this.followUpList,
    required this.displayType,
    this.maxItems,
    this.onViewAll,
    this.onItemTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final displayList = maxItems == null
        ? followUpList
        : followUpList.take(maxItems!).toList();

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 230,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                TextButton(
                  onPressed: onViewAll,
                  child: const Text(
                    "View All",
                    style: TextStyle(color: Colors.lightBlue),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text(
                    "Leads",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    displayType == FollowUpDisplayType.task
                        ? "Task"
                        : "Follow-up Date",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Status",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Divider(height: 24, thickness: 1, color: Colors.grey.shade300),

            Expanded(
              child: ListView.separated(
                separatorBuilder: (_, _) =>
                    Divider(color: Colors.grey.shade200, height: 1),
                itemCount: displayList.length,
                itemBuilder: (context, index) {
                  final selectedFollowUp = displayList[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => onItemTap?.call(selectedFollowUp),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              selectedFollowUp.leadName,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                              displayType == FollowUpDisplayType.task
                                  ? selectedFollowUp.task
                                  : selectedFollowUp.followUpDate.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              selectedFollowUp.status,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
