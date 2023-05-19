import 'dart:io';

import 'package:c317_mobile/components/action_button.dart';
import 'package:c317_mobile/components/input_textfield.dart';
import 'package:c317_mobile/exceptions/user_exception.dart';
import 'package:c317_mobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../utils/material_dialog.dart';
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
        child:
            Consumer<UserProvider>(builder: (_, UserProvider userProvider, __) {
          return Stack(alignment: Alignment.center, children: [
            (userProvider.isLoading)
                ? const Center(child: CircularProgressIndicator())
                : Container(),
            Opacity(
              opacity: (userProvider.isLoading) ? 0.5 : 1,
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
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
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
                          key: const Key('email'),
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
                        key: const Key('password'),
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
                          key: const Key('loginButton'),
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
                        key: const Key('forgotPasswordButton'),
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
            ),
          ]);
        }),
      ),
    );
  }

  _tryLogin(BuildContext context) async {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    String email = _emailController.text;
    String password = _passwordController.text;

    userProvider.login(email, password).then((_) {
      context.go('/onboarding');
    }).catchError(
      (e) {
        if (e is UserException) {
          MaterialDialog.showMaterialDialog(
              context: context, title: e.title, message: e.message);
        } else if (e is SocketException) {
          MaterialDialog.showMaterialDialog(
            context: context,
            title: 'Erro de conexão',
            message: 'Verifique sua conexão com a internet.',
          );
        } else {
          print(e);
          print(e.stackTrace);
          MaterialDialog.showMaterialDialog(
            context: context,
            title: 'Erro desconhecido',
            message:
                'Ocorreu um erro desconhecido. Tente novamente mais tarde.',
          );
        }
      },
    );
  }
}
