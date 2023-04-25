import 'package:c317_mobile/components/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../state/profile_picture_store.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<ProfilePictureStore>(context, listen: false).loadImage(),
      builder: (context, snapshot) {
        return Observer(
          builder: (_) {
            final image =
                Provider.of<ProfilePictureStore>(context, listen: false)
                    .imageBytes;
            return (image != null)
                ? UserAvatar(imageUrl: image)
                : const UserAvatar();
          },
        );
      },
    );
  }
}
