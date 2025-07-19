import 'package:flutter/material.dart';
import 'package:mini_instagram_task/screens/home_screen.dart';
import 'package:mini_instagram_task/screens/main_screen.dart';
import 'package:mini_instagram_task/screens/profile_screen.dart';

void main() {
  runApp(const MiniInstagramTask());
}

class MiniInstagramTask extends StatelessWidget {
  const MiniInstagramTask({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        MainScreen.id: (context) => const MainScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        ProfileScreen.id: (context) => const ProfileScreen(),
      },
      initialRoute: MainScreen.id,
      debugShowCheckedModeBanner: false,
    );
  }
}
