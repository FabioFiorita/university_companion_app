import 'package:beamer/beamer.dart';
import 'package:c317_mobile/screens/auth_screens/login_screen.dart';
import 'package:c317_mobile/screens/home_screen.dart';
import 'package:c317_mobile/screens/onboarding_screen.dart';

import '../screens/auth_screens/forgot_password_screen.dart';

final appRouter = RoutesLocationBuilder(
  routes: {
    '/': (context, state, data) => const LoginScreen(),
    '/forgot-password': (context, state, data) => const ForgotPasswordScreen(),
    '/onboarding': (context, state, data) => const OnboardingScreen(),
    '/home': (context, state, data) => const HomeScreen(),
  },
);
