import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/shared_preferences_provider.dart';

class ProfilePictureController {
  static Future<void> setImage(File image, BuildContext context) async {
    final prefs =
        Provider.of<SharedPreferencesProvider>(context, listen: false).prefs;
    final imageBytes = await image.readAsBytes();
    prefs?.setString(
      'image',
      base64Encode(imageBytes),
    );
  }

  static Uint8List? getImage(BuildContext context) {
    final String? imageString =
        Provider.of<SharedPreferencesProvider>(context, listen: false)
            .prefs
            ?.getString('image');
    if (imageString != null) {
      return base64Decode(imageString);
    } else {
      return null;
    }
  }
}
