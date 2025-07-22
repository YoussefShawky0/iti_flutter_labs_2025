import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class SocialLinksForm extends StatelessWidget {
  final UserProfile profile;
  final void Function(UserProfile) onChanged;

  const SocialLinksForm({
    super.key,
    required this.profile,
    required this.onChanged,
  });

  String? validateLink(String value) {
    if (value.isEmpty) return null;
    final isValid = Uri.tryParse(value)?.hasAbsolutePath ?? false;
    return isValid ? null : 'Enter a valid URL';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: profile.facebook,
          decoration: const InputDecoration(labelText: 'Facebook'),
          onChanged: (val) => onChanged(profile..facebook = val),
          validator: (val) => validateLink(val ?? ''),
        ),
        const SizedBox(height: 10),
        TextFormField(
          initialValue: profile.twitter,
          decoration: const InputDecoration(labelText: 'Twitter'),
          onChanged: (val) => onChanged(profile..twitter = val),
          validator: (val) => validateLink(val ?? ''),
        ),
        const SizedBox(height: 10),
        TextFormField(
          initialValue: profile.instagram,
          decoration: const InputDecoration(labelText: 'Instagram'),
          onChanged: (val) => onChanged(profile..instagram = val),
          validator: (val) => validateLink(val ?? ''),
        ),
      ],
    );
  }
}
