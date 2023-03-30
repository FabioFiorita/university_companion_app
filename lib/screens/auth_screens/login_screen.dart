import 'package:c317_mobile/components/action_button.dart';
import 'package:c317_mobile/components/input_textfield.dart';
import 'package:c317_mobile/themes/color_schemes.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(32.0),
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  height: 280,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: lightColorScheme.primary,
                      ),
                ),
              ),
              Container(
                height: 3,
                width: 100,
                color: lightColorScheme.primary,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: InputTextField(
                  isPassword: false,
                  label: 'Entre com seu e-mail...',
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const InputTextField(
                isPassword: true,
                label: 'Entre com sua senha...',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: ActionButton(
                  text: 'Entrar',
                  onPressed: () {
                    Navigator.pushNamed(context, '/onboarding');
                  },
                  color: lightColorScheme.primary,
                  textColor: lightColorScheme.onPrimary,
                ),
              ),
              ActionButton(
                text: 'Esqueci minha senha',
                onPressed: () {
                  Navigator.pushNamed(context, '/forgotPassword');
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
