import 'package:c317_mobile/components/action_button.dart';
import 'package:c317_mobile/components/input_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormFieldState> emailFormKey = GlobalKey();
  final GlobalKey<FormFieldState> passwordFormKey = GlobalKey();

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
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ),
              Container(
                height: 3,
                width: 100,
                color: Theme.of(context).primaryColor,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: InputTextField(
                  formFieldKey: emailFormKey,
                  isPassword: false,
                  label: 'Entre com seu e-mail...',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    return Validators.validateEmail(value);
                  },
                ),
              ),
              InputTextField(
                formFieldKey: passwordFormKey,
                isPassword: true,
                label: 'Entre com sua senha...',
                validator: (value) {
                  return Validators.validatePassword(value);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: ActionButton(
                  text: 'Entrar',
                  onPressed: () {
                    if (emailFormKey.currentState!.validate() &&
                        passwordFormKey.currentState!.validate()) {
                      context.go('/onboarding');
                    }
                  },
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).canvasColor,
                ),
              ),
              ActionButton(
                text: 'Esqueci minha senha',
                onPressed: () {
                  context.push('/forgot-password');
                },
                color: Theme.of(context).canvasColor,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
