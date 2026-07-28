import 'package:flutter/material.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/features/client_shell/widgets/menu_item.dart';
import 'package:go_router/go_router.dart';

class Sidebar extends StatelessWidget {
  final bool isCollapsed;
  final VoidCallback onToggle;

  const Sidebar({required this.isCollapsed, required this.onToggle, super.key});

  @override
  Widget build(BuildContext context) {
    return //sidebar
    AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isCollapsed ? 80 : 250,
      color: Colors.blueGrey,

      child: Column(
        children: [
          //menu button
          IconButton(
            onPressed: onToggle,
            icon: const Icon(Icons.menu, color: Colors.white),
          ),
          const SizedBox(height: 20),

          MenuItem(
            icon: Icons.dashboard,
            title: "Dashboard",
            isCollapsed: isCollapsed,
            isSelected: true,
            onTap: () {
              context.go(AppRoutes.EmployeeDashboard);
            },
          ),
          MenuItem(
            icon: Icons.people,
            title: "Leads",
            isCollapsed: isCollapsed,
            isSelected: false,
            onTap: () {
              context.go(AppRoutes.Leads);
            },
          ),
          MenuItem(
            icon: Icons.campaign,
            title: "campaigns",
            isCollapsed: isCollapsed,
            isSelected: false,
            onTap: () {
              context.go(AppRoutes.Campaign);
            },
          ),
          MenuItem(
            icon: Icons.settings,
            title: "settings",
            isCollapsed: isCollapsed,
            isSelected: false,
            onTap: () {
              context.go(AppRoutes.Settings);
            },
          ),
        ],
      ),
    );

    //main Content
  }
}
