import 'package:c317_mobile/components/user_avatar.dart';
import 'package:c317_mobile/providers/ProfilePictureProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilePictureProvider>(
      builder: (_, store, __) {
        final image = store.imageBytes;
        return (image != null)
            ? UserAvatar(imageUrl: image)
            : const UserAvatar();
      },
    );
  }
}
