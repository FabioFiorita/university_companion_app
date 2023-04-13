import 'package:c317_mobile/components/action_button.dart';
import 'package:c317_mobile/components/input_textfield.dart';
import 'package:c317_mobile/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  final GlobalKey<FormFieldState> emailFormKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar a senha'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Digite seu e-mail para recuperar a senha',
              style: TextStyle(fontSize: 18),
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
            ActionButton(
              text: 'Recuperar a senha',
              onPressed: () {
                if (emailFormKey.currentState!.validate()) {
                  context.pop();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
