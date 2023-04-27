import 'package:c317_mobile/components/action_button.dart';
import 'package:c317_mobile/components/input_textfield.dart';
import 'package:c317_mobile/utils/validators.dart';
import 'package:flutter/material.dart';

class GradeBottomSheet extends StatelessWidget {
  final VoidCallback onPressed;
  final TextEditingController gradeNameController;
  final TextEditingController gradeValueController;

  GradeBottomSheet(
      {Key? key,
      required this.onPressed,
      required this.gradeNameController,
      required this.gradeValueController})
      : super(key: key);

  final GlobalKey<FormFieldState> gradeName = GlobalKey();
  final GlobalKey<FormFieldState> gradeValue = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.4,
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0,
              MediaQuery.of(context).viewInsets.bottom + 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InputTextField(
                controller: gradeNameController,
                isPassword: false,
                formFieldKey: gradeName,
                label: "Avaliação",
                validator: (value) {
                  return Validators.validateTextField(value);
                },
              ),
              InputTextField(
                controller: gradeValueController,
                isPassword: false,
                formFieldKey: gradeValue,
                label: "Nota",
                validator: (value) {
                  return Validators.validateTextField(value);
                },
              ),
              ActionButton(
                text: "Adicionar nota",
                onPressed: onPressed,
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).canvasColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
