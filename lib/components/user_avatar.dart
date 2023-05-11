import 'dart:typed_data';

import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final Uint8List? imageUrl;

  const UserAvatar({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return CircleAvatar(
        radius: 40,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.person,
          size: 40,
          color: Theme.of(context).dialogBackgroundColor,
        ),
      );
    } else {
      return CircleAvatar(
        radius: 40,
        backgroundImage: MemoryImage(imageUrl!),
      );
    }
  }
}
