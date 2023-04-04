import 'package:beamer/beamer.dart';
import 'package:c317_mobile/routes/app_router.dart';
import 'package:c317_mobile/themes/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routerDelegate = BeamerDelegate(locationBuilder: appRouter);
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'UniApp',
      theme: appTheme,
      darkTheme: appThemeDark,
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
      backButtonDispatcher: BeamerBackButtonDispatcher(delegate: routerDelegate),
    );
  }
}
