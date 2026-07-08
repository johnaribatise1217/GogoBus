import 'package:bus_ticketing/features/auth/screens/complete_account_screen.dart';
import 'package:bus_ticketing/features/auth/screens/login_screen.dart';
import 'package:bus_ticketing/features/auth/screens/signup_screen.dart';
import 'package:bus_ticketing/features/auth/screens/verify_screen_otp.dart';
import 'package:bus_ticketing/features/home/models/terminal_data.dart';
import 'package:bus_ticketing/features/home/screens/home_screen.dart';
import 'package:bus_ticketing/features/home/screens/activity_screen.dart';
import 'package:bus_ticketing/features/home/screens/profile_screen.dart';
import 'package:bus_ticketing/features/home/screens/notification_screen.dart';
import 'package:bus_ticketing/features/onboarding/screens/get_started_screen.dart';
import 'package:bus_ticketing/features/onboarding/screens/onboarding_screen.dart';
import 'package:bus_ticketing/features/onboarding/screens/splash_screen.dart';
import 'package:bus_ticketing/features/search/models/schedule.dart';
import 'package:bus_ticketing/features/search/screens/search_result_screen.dart';
import 'package:bus_ticketing/features/tickets/buy-ticket/screen/buy_ticket_screen.dart';
import 'package:bus_ticketing/features/tickets/detail/screen/ticket_details_screen.dart';
import 'package:bus_ticketing/main_scaffold.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/get-started',
        builder: (context, state) => const GetStartedScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/verify-otp',
        builder: (context, state) =>
            const VerifyScreenOtp(email: 'aribatisejohn8@gmail.com'),
      ),
      GoRoute(
        path: '/complete-account',
        builder: (context, state) => const CompleteAccountScreen(),
      ),

      GoRoute(
        path: '/search-results',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return SearchResultScreen(
            departure: extra['departure'] as Terminal,
            destination: extra['destination'] as Terminal,
            date: extra['date'] as DateTime,
          );
        },
      ),

      GoRoute(
        path: '/ticket-details',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return TicketDetailsScreen(
            schedule: extra['schedule'] as Schedule,
            departure: extra['departure'] as Terminal,
            destination: extra['destination'] as Terminal,
            date: extra['date'] as DateTime,
          );
        },
      ),

      GoRoute(
        path: '/buy-ticket',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return BuyTicketScreen(
            schedule: extra['schedule'] as Schedule,
            departure: extra['departure'] as Terminal,
            destination: extra['destination'] as Terminal,
            date: extra['date'] as DateTime,
            passengers: extra['passengers'] as int
          );
        },
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/activity',
                builder: (context, state) => const ActivityScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/notifications',
                builder: (context, state) => const NotificationScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
