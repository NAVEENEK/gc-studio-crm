
import 'package:go_router/go_router.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/features/auth/ui/login_screen.dart';
import 'package:frontend/features/auth/ui/employee_dashboard.dart';
import 'package:frontend/features/auth/ui/agency_dashboard.dart';

class AppRouter {
  AppRouter._();

  static final router=GoRouter(
    initialLocation: AppRoutes.login,
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context,State)=> const LoginScreen(),
        ),

        GoRoute(
          path: AppRoutes.employeeDashboard,
          builder: (context,state)=>const EmployeeDashboard(),
          ),

          GoRoute(
            path: AppRoutes.agencyDashboard,
            builder: (context,state)=> const AgencyDashboard(),
            )
    ]
    );
}