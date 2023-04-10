import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  String? imageUrl;

  UserAvatar({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return CircleAvatar(
        radius: 40,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.person,
          size: 40,
        ),
      );
    } else {
      return CircleAvatar(
        radius: 40,
        backgroundImage: NetworkImage(imageUrl!),
      );
    }
  }
}
