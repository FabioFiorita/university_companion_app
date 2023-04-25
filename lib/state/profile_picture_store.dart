import 'dart:convert';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_picture_store.g.dart';

class ProfilePictureStore = _ProfilePictureStoreBase with _$ProfilePictureStore;

abstract class _ProfilePictureStoreBase with Store {
  late SharedPreferences _prefs;

  _ProfilePictureStoreBase() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @observable
  Uint8List? _imageBytes;

  @computed
  Uint8List? get imageBytes => _imageBytes;

  @action
  Future<bool> saveImage(XFile image) async {
    final imageBytes = await image.readAsBytes();
    final success = await _prefs.setString('image', base64Encode(imageBytes));
    if (success) {
      _imageBytes = imageBytes;
    }
    return success;
  }

  @action
  loadImage() {
    final String? imageString = _prefs.getString('image');
    if (imageString != null) {
      _imageBytes = base64Decode(imageString);
    }
  }

  @action
  deleteImage() {
    _prefs.remove('image');
    _imageBytes = null;
  }
}
