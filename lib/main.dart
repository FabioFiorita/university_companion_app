import 'package:c317_mobile/screens/auth_screens/forgot_password_screen.dart';
import 'package:c317_mobile/screens/auth_screens/login_screen.dart';
import 'package:c317_mobile/screens/onboarding_screen.dart';
import 'package:c317_mobile/themes/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniApp',
      theme: appTheme,
      darkTheme: appThemeDark,
      routes: {
        '/login': (context) => const LoginScreen(),
        '/forgotPassword': (context) => const ForgotPasswordScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
      },
      initialRoute: '/login',
    );
  }
}
