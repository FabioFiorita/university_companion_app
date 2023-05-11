import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String? title;
  final String? message;

  const ErrorMessage({Key? key, this.title, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (title != null)
              ? Text(
            title!,
            style: Theme
                .of(context)
                .textTheme
                .headlineMedium,
          )
              : const Text('Erro inesperado'),
          (message != null)
              ? Text(
            message!,
            style: Theme
                .of(context)
                .textTheme
                .bodyMedium,
          )
              : const Text('Tente novamente mais tarde.'),
        ],
      ),
    );
  }


}
