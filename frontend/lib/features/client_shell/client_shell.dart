import 'package:flutter/material.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/core/storage/storage_service.dart';
import 'package:frontend/features/client_shell/widgets/profile_icon.dart';
import 'package:frontend/features/client_shell/widgets/sidebar.dart';
import 'package:go_router/go_router.dart';

class ClientShell extends StatefulWidget {
  final Widget child;

  const ClientShell({super.key, required this.child});

  @override
  State<ClientShell> createState() => _ClientShellState();
}

class _ClientShellState extends State<ClientShell> {
  final StorageService _storageService = StorageService();

  String employeeName = "";
  String employeeRole = "";

  bool isCollapsed = true;

  void toggleSidebar() {
    setState(() {
      isCollapsed = !isCollapsed;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final name = await _storageService.getName();
    final role = await _storageService.getRole();
    if (!mounted) return;

    setState(() {
      employeeName = name ?? "";
      employeeRole = role ?? "";
    });
  }

  Future<void> _logout() async{
    await _storageService.clear();
    if(!mounted) return;
    context.go(AppRoutes.loginScreen);
  }

  Future<void> _showLogoutDialog() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("cancel"),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
    if (shouldLogout == true) {
      _logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AppBar")),
      body: SafeArea(
        child: Row(
          children: [
            Sidebar(
              isCollapsed: isCollapsed,
              onToggle: toggleSidebar,

              profileWidget: ProfileIcon(
                employeeName: employeeName,
                employeeRole: employeeRole,
                isCollapsed: isCollapsed,
                onProfileTap: () {
                  //navigate profile page
                  context.go(AppRoutes.ProfileScreen);
                },
                onLogoutTap: () {
                  //logout
                  _showLogoutDialog();
                },
              ),
            ),
            Expanded(child: widget.child),
          ],
        ),
      ),
    );
  }
}
