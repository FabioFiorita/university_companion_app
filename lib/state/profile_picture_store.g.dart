// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_picture_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfilePictureStore on _ProfilePictureStoreBase, Store {
  Computed<Uint8List?>? _$imageBytesComputed;

  @override
  Uint8List? get imageBytes =>
      (_$imageBytesComputed ??= Computed<Uint8List?>(() => super.imageBytes,
              name: '_ProfilePictureStoreBase.imageBytes'))
          .value;

  late final _$_imageBytesAtom =
      Atom(name: '_ProfilePictureStoreBase._imageBytes', context: context);

  @override
  Uint8List? get _imageBytes {
    _$_imageBytesAtom.reportRead();
    return super._imageBytes;
  }

  @override
  set _imageBytes(Uint8List? value) {
    _$_imageBytesAtom.reportWrite(value, super._imageBytes, () {
      super._imageBytes = value;
    });
  }

  late final _$saveImageAsyncAction =
      AsyncAction('_ProfilePictureStoreBase.saveImage', context: context);

  @override
  Future<bool> saveImage(XFile image) {
    return _$saveImageAsyncAction.run(() => super.saveImage(image));
  }

  late final _$_ProfilePictureStoreBaseActionController =
      ActionController(name: '_ProfilePictureStoreBase', context: context);

  @override
  dynamic loadImage() {
    final _$actionInfo = _$_ProfilePictureStoreBaseActionController.startAction(
        name: '_ProfilePictureStoreBase.loadImage');
    try {
      return super.loadImage();
    } finally {
      _$_ProfilePictureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteImage() {
    final _$actionInfo = _$_ProfilePictureStoreBaseActionController.startAction(
        name: '_ProfilePictureStoreBase.deleteImage');
    try {
      return super.deleteImage();
    } finally {
      _$_ProfilePictureStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
imageBytes: ${imageBytes}
    ''';
  }
}
