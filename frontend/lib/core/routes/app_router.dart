import 'package:flutter/material.dart';
import 'package:frontend/features/campaigns/campaign.dart';
import 'package:frontend/features/client_shell/client_shell.dart';
import 'package:frontend/features/leads/leads.dart';
import 'package:frontend/features/settings/settings.dart';
import 'package:frontend/features/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/features/auth/ui/login_screen.dart';
import 'package:frontend/features/dashboard/ui/employee_dashboard.dart';
import 'package:frontend/features/dashboard/ui/agency_dashboard.dart';

class AppRouter {
  AppRouter._();

  static final router = GoRouter(
    initialLocation: AppRoutes.splashScreen,
    routes: [
      GoRoute(
        path: AppRoutes.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.loginScreen,
        builder: (context, State) => const LoginScreen(),
      ),

      GoRoute(
        path: AppRoutes.EmployeeDashboard,
        builder: (context, state) => const EmployeeDashboard(),
      ),

      GoRoute(
        path: AppRoutes.agencyDashboard,
        builder: (context, state) => const AgencyDashboard(),
      ),
      GoRoute(
        path: AppRoutes.Leads,
        builder: (Context, State) => const Leads(),
      ),
      GoRoute(
        path: AppRoutes.Campaign,
        builder: (Context, State) => const Campaign(),
      ),
      GoRoute(
        path: AppRoutes.Settings,
        builder: (Context, State) => const Settings(),
      ),
      GoRoute(
        path: AppRoutes.ClientShell,
        builder: (Context, State) => ClientShell(),
      ),
    ],
  );
}
