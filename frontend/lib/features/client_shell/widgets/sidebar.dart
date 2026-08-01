import 'package:flutter/material.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/features/client_shell/widgets/menu_item.dart';
import 'package:go_router/go_router.dart';

class Sidebar extends StatelessWidget {
  final bool isCollapsed;
  final VoidCallback onToggle;
  final Widget profileWidget;

  const Sidebar({
    required this.isCollapsed, 
    required this.onToggle, 
    required this.profileWidget,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    final currentLocation=GoRouterState.of(context).uri.path;
    return //sidebar
    AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isCollapsed ? 80 : 250,
      color: AppColors.surface,

      child: Column(
        children: [
          //menu button
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: onToggle,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.menu, color: AppColors.textPrimary),
              ),
            ),
          ),
          const SizedBox(height: 20),

          MenuItem(
            icon: Icons.dashboard,
            title: "Dashboard",
            isCollapsed: isCollapsed,
            isSelected: currentLocation==AppRoutes.clientDashboard,
            onTap: () {
              context.go(AppRoutes.clientDashboard);
            },
          ),
          MenuItem(
            icon: Icons.people,
            title: "Leads",
            isCollapsed: isCollapsed,
            isSelected: currentLocation==AppRoutes.clientLeads,
            onTap: () {
              context.go(AppRoutes.clientLeads);
            },
          ),
          MenuItem(
            icon: Icons.campaign,
            title: "campaigns",
            isCollapsed: isCollapsed,
            isSelected: currentLocation==AppRoutes.clientCampaigns,
            onTap: () {
              context.go(AppRoutes.clientCampaigns);
            },
          ),
          MenuItem(
            icon: Icons.settings,
            title: "settings",
            isCollapsed: isCollapsed,
            isSelected: currentLocation==AppRoutes.clientSettings,
            onTap: () {
              context.go(AppRoutes.clientSettings);
            },
          ),

          const Spacer(),

          profileWidget,

        ],
      ),
    );

    //main Content
  }
}
