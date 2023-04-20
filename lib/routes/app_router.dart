import 'package:c317_mobile/screens/classes_schedule_screen.dart';
import 'package:c317_mobile/screens/grades_screens/subject_grade_screen.dart';
import 'package:c317_mobile/screens/home_screen.dart';
import 'package:c317_mobile/screens/information_list_screen.dart';
import 'package:c317_mobile/screens/navigation_screen.dart';
import 'package:c317_mobile/screens/auth_screens/login_screen.dart';
import 'package:c317_mobile/screens/onboarding_screen.dart';
import 'package:c317_mobile/screens/profile_screen.dart';
import 'package:c317_mobile/screens/grades_screens/subjects_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/auth_screens/forgot_password_screen.dart';

final _parentKey = GlobalKey<NavigatorState>(debugLabel: 'parent');
final _shellKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

class AppRouter {
  static final isAuth = ValueNotifier<bool>(true);
  static final routerConfig = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: isAuth.value ? '/' : '/login',
    navigatorKey: _parentKey,
    routes: [
      GoRoute(
        path: '/login',
        parentNavigatorKey: _parentKey,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        parentNavigatorKey: _parentKey,
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        parentNavigatorKey: _parentKey,
        builder: (context, state) => const OnboardingScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellKey,
        builder: (context, state, child) {
          return NavigationScreen(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            parentNavigatorKey: _shellKey,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: HomeScreen()),
            routes: [
              GoRoute(
                name: 'information',
                path: ':title/:subtitle/:isTeacherList',
                parentNavigatorKey: _parentKey,
                builder: (context, state) => InformationListScreen(
                  title: state.params['title']!,
                  listLabel: state.params['subtitle']!,
                  isTeacherList:
                      (state.params['isTeacherList']! == 'true') ? true : false,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/classes',
            parentNavigatorKey: _shellKey,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ClassesScheduleScreen()),
          ),
          GoRoute(
              path: '/subjects',
              parentNavigatorKey: _shellKey,
              pageBuilder: (context, state) => const NoTransitionPage(
                    child: SubjectListScreen(),
                  ),
              routes: [
                GoRoute(
                  path: ':subject',
                  parentNavigatorKey: _parentKey,
                  builder: (context, state) {
                    return SubjectGradeScreen(
                      subject: state.params['subject']!,
                    );
                  },
                ),
              ]),
          GoRoute(
            path: '/profile',
            parentNavigatorKey: _shellKey,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ProfileScreen()),
          ),
        ],
      ),
    ],
  );
}
