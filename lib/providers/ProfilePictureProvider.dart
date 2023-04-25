import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePictureProvider extends ChangeNotifier {
  late SharedPreferences _prefs;

  ProfilePictureProvider(SharedPreferences prefs) {
    _initPrefs(prefs);
  }

  Future<void> _initPrefs(SharedPreferences prefs) async {
    _prefs = prefs;
    loadImage();
    notifyListeners();
  }

  Uint8List? _imageBytes;

  Uint8List? get imageBytes => _imageBytes;

  Future<bool> saveImage(XFile image) async {
    final imageBytes = await image.readAsBytes();
    final success = await _prefs.setString('image', base64Encode(imageBytes));
    if (success) {
      _imageBytes = imageBytes;
      notifyListeners();
    }
    return success;
  }

  loadImage() {
    final String? imageString = _prefs.getString('image');
    if (imageString != null) {
      _imageBytes = base64Decode(imageString);
      notifyListeners();
    }
  }

  deleteImage() {
    _prefs.remove('image');
    _imageBytes = null;
    notifyListeners();
  }
}
