import 'package:flutter/material.dart';

import '../models/user_profile.dart';
import '../widgets/editable_profile_image.dart';
import '../widgets/profile_text_fields.dart';
import '../widgets/save_cancel_buttons.dart';
import '../widgets/social_links_form.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProfile profile;
  late UserProfile originalProfile;

  @override
  void initState() {
    super.initState();
    profile = UserProfile.initial();
    originalProfile = UserProfile.initial();
  }

  void resetProfile() {
    setState(() {
      profile = UserProfile.initial();
    });
  }

  void saveProfile() {
    originalProfile = UserProfile(
      name: profile.name,
      bio: profile.bio,
      facebook: profile.facebook,
      twitter: profile.twitter,
      instagram: profile.instagram,
      profileImagePath: profile.profileImagePath,
    );
  }

  void cancelChanges() {
    setState(() {
      profile = UserProfile(
        name: originalProfile.name,
        bio: originalProfile.bio,
        facebook: originalProfile.facebook,
        twitter: originalProfile.twitter,
        instagram: originalProfile.instagram,
        profileImagePath: originalProfile.profileImagePath,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            EditableProfileImage(
              imagePath: profile.profileImagePath,
              onImageSelected: (newPath) {
                setState(() {
                  profile.profileImagePath = newPath;
                });
              },
            ),
            const SizedBox(height: 16),
            ProfileTextFields(
              profile: profile,
              onChanged: (updated) => setState(() => profile = updated),
            ),
            const SizedBox(height: 16),
            SocialLinksForm(
              profile: profile,
              onChanged: (updated) => setState(() => profile = updated),
            ),
            const SizedBox(height: 24),
            SaveCancelButtons(onSave: saveProfile, onCancel: cancelChanges),
          ],
        ),
      ),
    );
  }
}
