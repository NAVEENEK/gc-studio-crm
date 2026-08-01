import 'package:flutter/material.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/core/storage/storage_service.dart';
import 'package:frontend/features/client_shell/widgets/sidebar.dart';
import 'package:go_router/go_router.dart';

class ClientShell extends StatefulWidget {
  final Widget child;

  const ClientShell({
    super.key,
    required this.child,
  });

  @override
  State<ClientShell> createState() => _ClientShellState();
}

class _ClientShellState extends State<ClientShell> {
  bool isCollapsed = true;

  void toggleSidebar() {
    setState(() {
      isCollapsed = !isCollapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AppBar"),
      ),
      body: SafeArea(
        child: Row(
          children: [
            Sidebar(
              isCollapsed: isCollapsed,
              onToggle: toggleSidebar,
            ),

            Expanded(
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}