import 'package:c317_mobile/routes/app_router.dart';
import 'package:c317_mobile/themes/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'UniApp',
      theme: appTheme,
      darkTheme: darkAppTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.routerConfig,
    );
  }
}
