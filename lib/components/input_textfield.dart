import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  final String? label;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool isPassword;

  const InputTextField({Key? key, this.label, this.keyboardType, this.controller, required this.isPassword}) : super(key: key);

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? _showPassword : false,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword ? InkWell(
          onTap: () {
            setState(() => _showPassword = !_showPassword);
          },
          borderRadius: BorderRadius.circular(10.0),
          child: _showPassword
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
        ) : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        labelText: widget.label,
      ),
    );
  }
}