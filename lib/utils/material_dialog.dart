import 'package:flutter/material.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

class MaterialDialog {
  static void showMaterialDialog(
      BuildContext context, String title, String message) {
    Dialogs.materialDialog(
        context: context,
        title: title,
        msg: message,
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
  }
}
