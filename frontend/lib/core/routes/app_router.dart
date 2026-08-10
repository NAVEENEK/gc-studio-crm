import 'package:frontend/features/campaigns/campaign.dart';
import 'package:frontend/features/client_shell/client_shell.dart';
import 'package:frontend/features/dashboard/ui/client_dashboard.dart';
import 'package:frontend/features/followups/ui/followups.dart';
import 'package:frontend/features/followups/ui/followups_info.dart';
import 'package:frontend/features/leads/ui/lead_info.dart';
import 'package:frontend/features/leads/ui/leads.dart';
import 'package:frontend/features/profile/profile.dart';
import 'package:frontend/features/settings/settings.dart';
import 'package:frontend/features/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/features/auth/ui/login_screen.dart';
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
        path: AppRoutes.agencyDashboard,
        builder: (context, state) => const AgencyDashboard(),
      ),

      ShellRoute(
        builder: (Context, State, child) {
          return ClientShell(child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.clientDashboard,
            builder: (context, state) => const ClientDashboard(),
          ),
          GoRoute(
            path: AppRoutes.clientCampaigns,
            builder: (Context, State) => const Campaign(),
          ),
          GoRoute(
            path: AppRoutes.clientSettings,
            builder: (Context, State) => const Settings(),
          ),
          GoRoute(
            path: AppRoutes.ProfileScreen,
            builder: (Context, State) => const ProfileScreen(),
          ),
          GoRoute(
            path: AppRoutes.clientLeadInfo,
            builder: (Context, State) => const LeadInfo(),
          ),
          GoRoute(
            path: AppRoutes.clientLeads,
            builder: (Context, State) => const Leads(),
          ),
          GoRoute(
            path: AppRoutes.clientFollowUps,
            builder: (Context, State) => const FollowUps(),
          ),
          GoRoute(
            path: AppRoutes.clientFollowUpsInfo,
            builder: (context,state)=>const FollowUpsInfo()
            ), 
        ],
      ),
    ],
  );
}
