import 'package:c317_mobile/themes/color_schemes.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  String? imageUrl;
  UserAvatar({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return CircleAvatar(
        backgroundColor: lightColorScheme.primary,
        child: const Icon(Icons.person),
      );
    } else {
      return CircleAvatar(
        backgroundImage: NetworkImage(imageUrl!),
      );
    }
  }
}
