import 'package:flutter/material.dart';

void showProfileImageModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Dialog(child: Image.asset('assets/profile.jpg')),
  );
}
