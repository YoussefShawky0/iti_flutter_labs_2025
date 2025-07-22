import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class ProfileTextFields extends StatelessWidget {
  final UserProfile profile;
  final void Function(UserProfile) onChanged;

  const ProfileTextFields({
    super.key,
    required this.profile,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: profile.name);
    final bioController = TextEditingController(text: profile.bio);

    return Column(
      children: [
        TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Name'),
          onChanged: (val) =>
              onChanged(profile..name = val),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: bioController,
          decoration: const InputDecoration(labelText: 'Bio'),
          onChanged: (val) =>
              onChanged(profile..bio = val),
        ),
      ],
    );
  }
}
