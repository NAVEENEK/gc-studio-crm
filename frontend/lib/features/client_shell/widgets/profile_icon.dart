import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileIcon extends StatelessWidget {
  final bool isCollapsed;
  final String employeeName;
  final String employeeRole;

  final VoidCallback onProfileTap;
  final VoidCallback onLogoutTap;

  const ProfileIcon({
    required this.employeeName,
    required this.employeeRole,
    required this.isCollapsed,
    required this.onProfileTap,
    required this.onLogoutTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal: isCollapsed ? 8 : 12,
        vertical: 12
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //-----profile------
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onProfileTap,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.person_2_outlined),
                  ),

                  if (!isCollapsed) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            employeeName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),

                          const SizedBox(height: 2),
                          Text(
                            employeeRole,
                            style: const TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Icon(Icons.chevron_right, size: 18),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),
          //------logout------
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onLogoutTap,
            child: Padding(
              padding:  EdgeInsets.symmetric(
                horizontal: isCollapsed ? 8 : 12,
                vertical: 12
              ),
              child: Row(
                children: [
                  const Icon(Icons.logout_rounded, color: Colors.red),

                  if (!isCollapsed) ...[
                    const SizedBox(width: 12),

                    const Text("Logout", style: TextStyle(color: Colors.red)),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
