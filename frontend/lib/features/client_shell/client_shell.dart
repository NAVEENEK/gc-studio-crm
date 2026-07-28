import 'package:flutter/material.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/features/client_shell/widgets/menu_item.dart';
import 'package:frontend/features/client_shell/widgets/sidebar.dart';
import 'package:go_router/go_router.dart';

class ClientShell extends StatefulWidget {
  const ClientShell({super.key});

  @override
  State<ClientShell> createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<ClientShell> {

  bool isCollapsed = true;

  void toggleSidebar(){
    setState(() {
      isCollapsed=!isCollapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AppBar"),   
      ),
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Sidebar(
              isCollapsed:isCollapsed,
              onToggle:toggleSidebar
            ),

              //main Content
              Expanded(
               child: Text('data'),
                )
            
          ],
        )
        ),
    );
  }
}