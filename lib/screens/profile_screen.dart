import 'dart:io';

import 'package:c317_mobile/components/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../controller/profile_picture_controller.dart';
import '../models/shared_preferences_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final image = ProfilePictureController.getImage(context);
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
              (image != null)
                  ? UserAvatar(imageUrl: image)
                  : GestureDetector(
                      onTap: () {
                        picker
                            .pickImage(
                              source: ImageSource.gallery,
                            )
                            .then(
                              (image) => {
                                if (image != null)
                                  {
                                    setState(() {
                                      ProfilePictureController.setImage(
                                          File(image.path), context);
                                    }),
                                  }
                              },
                            );
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          const UserAvatar(),
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
                  Provider.of<SharedPreferencesProvider>(context, listen: false)
                      .prefs
                      ?.remove('image');
                  context.replace('/login');
                },
                icon: const Icon(Icons.exit_to_app_rounded),
                color: Theme.of(context).colorScheme.error,
              ),
            ],
          ),
          Text(
            'Avner Joseph',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              'avner.joseph@gep.inatel.br',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
          Text(
            'GEP',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          Text(
            '1669',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
        ],
      ),
    ));
  }
}
