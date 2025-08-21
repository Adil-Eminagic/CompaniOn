import 'package:companion_mobile/utils/util.dart';
import 'package:flutter/material.dart';

import '../../../core/components/network_image.dart';
import '../../../core/constants/constants.dart';
import '../../../utils/util.dart';
import '../../../utils/util_widgets.dart';
import 'profile_header_options.dart';
import 'package:companion_mobile/models/photos.dart';
import 'package:companion_mobile/core/routes/app_routes.dart';
import 'package:companion_mobile/core/utils/validators.dart';
import 'package:companion_mobile/providers/users_provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Background
        Positioned.fill(
          child: Image.asset(
            'assets/images/profile_page_background.png',
            fit: BoxFit.cover,
          ),
        ),

        /// Content
        Column(
          children: [
            AppBar(
              title: const Text('Profile'),
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const _UserData(),
          ],
        ),
      ],
    );
  }
}

class _UserData extends StatefulWidget {
  const _UserData();

  @override
  State<_UserData> createState() => _UserDataState();
}

class _UserDataState extends State<_UserData> {
  bool isVisible = loggedUser?.isVisibleToOthers ?? false;

  Future<void> _toggleVisibility(bool value) async {
    try {
      await UsersProvider().updateVisibility(loggedUser!.id!, value);
      setState(() {
        isVisible = value;
      });

      // Ažuriraj lokalni objekat ako koristiš globalni singleton
      loggedUser?.isVisibleToOthers = value;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Visibility updated successfully.")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update visibility: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Row(
        children: [
          const SizedBox(width: AppDefaults.padding),
          loggedUser?.profilePhotoId != null && loggedUser!.profilePhotoId! > 0
              ? SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipOval(
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: NetworkImageWithLoader(
                        'https://example.com/path/to/profile/image/${loggedUser!.profilePhotoId}',
                      ),
                    ),
                  ),
                )
              : const SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipOval(
                    child: Icon(
                      Icons.account_circle_sharp,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                ),
          const SizedBox(width: AppDefaults.padding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${loggedUser?.firstName ?? "First Name"} ${loggedUser?.lastName ?? "Last Name"}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Age: ${loggedUser?.birthDate != null ? calculateAge(loggedUser!.birthDate!) : "Unknown"} years old',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      'Visible to others',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Switch(
                      value: isVisible,
                      onChanged: (value) => _toggleVisibility(value),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

int calculateAge(DateTime birthDate) {
  final currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  if (currentDate.month < birthDate.month ||
      (currentDate.month == birthDate.month &&
          currentDate.day < birthDate.day)) {
    age--;
  }
  return age;
}
