import 'package:c317_mobile/providers/class_provider.dart';
import 'package:c317_mobile/providers/contact_provider.dart';
import 'package:c317_mobile/providers/exam_provider.dart';
import 'package:c317_mobile/providers/profile_picture_provider.dart';
import 'package:c317_mobile/providers/subject_provider.dart';
import 'package:c317_mobile/providers/teacher_provider.dart';
import 'package:c317_mobile/providers/user_provider.dart';
import 'package:c317_mobile/routes/app_router.dart';
import 'package:c317_mobile/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ProfilePictureProvider>(
          create: (_) => ProfilePictureProvider(prefs),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(prefs),
        ),
        ChangeNotifierProxyProvider<UserProvider, SubjectProvider>(
          update: (context, userProvider, previousSubject) =>
              SubjectProvider(userProvider.user),
          create: (BuildContext context) => SubjectProvider(null),
        ),
        ChangeNotifierProxyProvider<UserProvider, ExamProvider>(
          update: (context, userProvider, previousGrade) =>
              ExamProvider(userProvider.user),
          create: (BuildContext context) => ExamProvider(null),
        ),
        ChangeNotifierProxyProvider<UserProvider, ClassProvider>(
          update: (context, userProvider, previousGrade) =>
              ClassProvider(userProvider.user),
          create: (BuildContext context) => ClassProvider(null),
        ),
        ChangeNotifierProvider<ContactProvider>(
          create: (_) => ContactProvider(),
        ),
        ChangeNotifierProxyProvider<UserProvider, TeacherProvider>(
          update: (context, userProvider, previousGrade) =>
              TeacherProvider(userProvider.user),
          create: (BuildContext context) => TeacherProvider(null),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppRouter router = AppRouter(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'UniApp',
      theme: appTheme,
      darkTheme: darkAppTheme,
      themeMode: ThemeMode.system,
      routerConfig: router.routerConfig,
    );
  }
}
