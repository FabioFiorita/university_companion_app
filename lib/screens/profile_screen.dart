import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../components/profile_picture.dart';
import '../state/profile_picture_store.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final ProfilePictureStore profilePictureStore =
        Provider.of<ProfilePictureStore>(context, listen: false);
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
                onTap: () {
                  picker
                      .pickImage(
                        source: ImageSource.gallery,
                      )
                      .then(
                        (image) => {
                          if (image != null)
                            {
                              profilePictureStore.saveImage(image),
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
                  profilePictureStore.deleteImage();
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
