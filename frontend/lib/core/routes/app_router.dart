import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/features/auth/ui/widgets/login_form.dart';
import 'package:frontend/features/auth/ui/employee_dashboard.dart';

class AppRouter {
  AppRouter._();

  static final router=GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context,State)=> const LoginForm(),
        ),

        GoRoute(
          path: AppRoutes.employeeDashboard,
          builder: (context,state)=>const EmployeeDashboard(),
          )
    ]
    );
}