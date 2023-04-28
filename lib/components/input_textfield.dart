import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  final String? label;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool isPassword;
  final String? Function(String?)? validator;
  final GlobalKey<FormFieldState> formFieldKey;
  final bool? autofocus;

  const InputTextField(
      {Key? key,
      this.label,
      this.keyboardType,
      this.controller,
      required this.isPassword,
      this.validator,
      required this.formFieldKey,
      this.autofocus})
      : super(key: key);

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.formFieldKey,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? _hidePassword : false,
      validator: widget.validator,
      autofocus: (widget.autofocus == null) ? false : widget.autofocus!,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? InkWell(
                onTap: () {
                  setState(() => _hidePassword = !_hidePassword);
                },
                borderRadius: BorderRadius.circular(10.0),
                child: _hidePassword
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              )
            : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        labelText: widget.label,
      ),
    );
  }
}
