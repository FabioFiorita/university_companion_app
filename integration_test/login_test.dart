import 'package:c317_mobile/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Test Login Screen when login process is successful", (
      widgetTester) async {
    app.main();
    await widgetTester.pumpAndSettle();
    String email = "avner@inatel.br";
    String password = "password123";
    expect(find.text("Login"), findsOneWidget);
    await widgetTester.enterText(find.byKey(const Key("email")), email);
    expect(find.text("avner@inatel.br"), findsOneWidget);
    await widgetTester.enterText(find.byKey(const Key("password")), password);
    FocusScope.of(widgetTester.element(find.byKey(const Key("password"))))
        .unfocus();
    await widgetTester.pumpAndSettle();
    expect(find.text("password123"), findsOneWidget);
    await widgetTester.tap(find.byKey(const Key("loginButton")));
    await widgetTester.pumpAndSettle();
    expect(find.byKey(const Key('onboarding')), findsOneWidget);
  });

  testWidgets(
      "Test Login Screen when password is incorrect", (widgetTester) async {
    app.main();
    await widgetTester.pumpAndSettle();
    String email = "avner@inatel.br";
    String password = "password1234";
    expect(find.text("Login"), findsOneWidget);
    await widgetTester.enterText(find.byKey(const Key("email")), email);
    expect(find.text("avner@inatel.br"), findsOneWidget);
    await widgetTester.enterText(find.byKey(const Key("password")), password);
    FocusScope.of(widgetTester.element(find.byKey(const Key("password"))))
        .unfocus();
    await widgetTester.pumpAndSettle();
    expect(find.text("password1234"), findsOneWidget);
    await widgetTester.tap(find.byKey(const Key("loginButton")));
    await widgetTester.pumpAndSettle();
    expect(find.text("Não autorizado"), findsOneWidget);
  });
}
