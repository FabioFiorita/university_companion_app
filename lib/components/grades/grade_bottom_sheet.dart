import 'package:c317_mobile/components/action_button.dart';
import 'package:c317_mobile/components/input_textfield.dart';
import 'package:c317_mobile/utils/validators.dart';
import 'package:flutter/material.dart';

class GradeBottomSheet extends StatelessWidget {
  final VoidCallback onPressed;
  final TextEditingController gradeNameController;
  final TextEditingController gradeValueController;

  const GradeBottomSheet(
      {Key? key,
      required this.onPressed,
      required this.gradeNameController,
      required this.gradeValueController})
      : super(key: key);

  static final GlobalKey<FormFieldState> gradeName = GlobalKey();
  static final GlobalKey<FormFieldState> gradeValue = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Form(
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
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: InputTextField(
                    controller: gradeValueController,
                    isPassword: false,
                    formFieldKey: gradeValue,
                    label: "Nota",
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      return Validators.validateTextField(value);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: ActionButton(
                    text: "Adicionar nota",
                    onPressed: onPressed,
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).canvasColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
