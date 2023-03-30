import 'package:c317_mobile/components/action_button.dart';
import 'package:c317_mobile/components/input_textfield.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

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
            const Padding(
              padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: InputTextField(
                isPassword: false,
                label: 'Entre com seu e-mail...',
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            ActionButton(
              text: 'Recuperar a senha',
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }
}
