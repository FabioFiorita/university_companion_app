import 'dart:io';

import 'package:c317_mobile/components/action_button.dart';
import 'package:c317_mobile/components/input_textfield.dart';
import 'package:c317_mobile/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

import '../../exceptions/user_not_found_exception.dart';
import '../../utils/validators.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final GlobalKey<FormFieldState> emailFormKey = GlobalKey();
  final GlobalKey<FormFieldState> passwordFormKey = GlobalKey();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                  controller: _emailController,
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
                controller: _passwordController,
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
                      _tryLogin(context);
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

  _tryLogin(BuildContext context) async {
    final AuthService authService = AuthService(context: context);
    String email = _emailController.text;
    String password = _passwordController.text;

    authService.login(email, password).then((token) {
      context.go('/onboarding');
    }).catchError((e) {
      Dialogs.materialDialog(
        context: context,
        title: "Usuário ainda não existe",
        msg: "Verifique com a universidade se você já foi cadastrado.",
        actions: [
          IconsButton(
            onPressed: () {
              Navigator.pop(context);
            },
            text: "Ok",
            color: Theme.of(context).primaryColor,
            iconData: Icons.check_rounded,
            textStyle: TextStyle(color: Theme.of(context).canvasColor),
            iconColor: Theme.of(context).canvasColor,
          ),
        ],
      );
    }, test: (e) => e is UserNotFoundException).catchError((e) {
      HttpException exception = e as HttpException;
      Dialogs.materialDialog(
          context: context,
          title: "Erro",
          msg: exception.message,
          actions: [
            IconsButton(
              onPressed: () {
                Navigator.pop(context);
              },
              text: "Ok",
              color: Theme.of(context).primaryColor,
              iconData: Icons.check_rounded,
              textStyle: TextStyle(color: Theme.of(context).canvasColor),
              iconColor: Theme.of(context).canvasColor,
            ),
          ]);
    }, test: (e) => e is HttpException);
  }
}
