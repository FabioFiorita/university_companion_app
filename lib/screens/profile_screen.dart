import 'package:c317_mobile/providers/profile_picture_provider.dart';
import 'package:c317_mobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../components/profile_picture.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final ProfilePictureProvider profilePictureProvider =
        Provider.of<ProfilePictureProvider>(context, listen: false);
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 56.0, 24.0, 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  await picker
                      .pickImage(
                        source: ImageSource.gallery,
                      )
                      .then(
                        (image) => {
                          if (image != null)
                            {
                              profilePictureProvider.saveImage(image),
                            }
                        },
                      );
                },
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const ProfilePicture(),
                    CircleAvatar(
                      radius: 16,
                      child: Icon(
                        Icons.edit,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  profilePictureProvider.deleteImage();
                  userProvider.clearUser();
                  context.replace('/login');
                },
                icon: const Icon(Icons.exit_to_app_rounded),
                color: Theme.of(context).colorScheme.error,
              ),
            ],
          ),
          Text(
            userProvider.user?.name ?? '',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              userProvider.user?.email ?? '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
          Text(
            userProvider.user?.course ?? '',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          Text(
            userProvider.user?.enrollmentNumber ?? '',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
        ],
      ),
    ));
  }
}
