import 'package:beamer/beamer.dart';
import 'package:c317_mobile/routes/navigation_screen.dart';
import 'package:c317_mobile/screens/auth_screens/login_screen.dart';
import 'package:c317_mobile/screens/home_screen.dart';
import 'package:c317_mobile/screens/onboarding_screen.dart';

import '../screens/auth_screens/forgot_password_screen.dart';

final appRouter = RoutesLocationBuilder(
  routes: {
    '/login': (context, state, data) => const LoginScreen(),
    '/forgot-password': (context, state, data) => const ForgotPasswordScreen(),
    '/onboarding': (context, state, data) => const OnboardingScreen(),
    '/home': (context, state, data) {
      int initialIndex = 0;
      switch (state.queryParameters['tab']) {
        case 'schedule':
          initialIndex = 1;
          break;
        case 'grades':
          initialIndex = 2;
          break;
        case 'profile':
          initialIndex = 3;
          break;
      }
      return NavigationScreen(initialIndex: initialIndex);
    },
  },
);
