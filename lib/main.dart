import 'package:c317_mobile/providers/ProfilePictureProvider.dart';
import 'package:c317_mobile/routes/app_router.dart';
import 'package:c317_mobile/state/user_store.dart';
import 'package:c317_mobile/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ProfilePictureProvider>(
        create: (_) => ProfilePictureProvider(prefs),
      ),
      Provider<UserStore>(
        create: (_) => UserStore(prefs),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    UserStore userStore = Provider.of<UserStore>(context);
    AppRouter router = AppRouter(userStore);
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
