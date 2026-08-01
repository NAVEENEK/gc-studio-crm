import 'package:flutter/material.dart';
import 'package:frontend/core/storage/storage_service.dart';
import 'package:frontend/features/client_shell/widgets/profile_icon.dart';
import 'package:frontend/features/client_shell/widgets/sidebar.dart';

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
    employeeName = await _storageService.getName() ?? "";
    employeeRole = await _storageService.getRole() ?? "";

    if (!mounted) return;

    setState(() {});
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
                },
                onLogoutTap: () {
                  //logout
                },
              ),
            ),

            //call profile +logout
            Expanded(child: widget.child),
          ],
        ),
      ),
    );
  }
}
