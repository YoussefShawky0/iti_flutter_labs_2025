import 'package:flutter/material.dart';

import 'screens/social_card_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Social Media Card',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SocialCardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
