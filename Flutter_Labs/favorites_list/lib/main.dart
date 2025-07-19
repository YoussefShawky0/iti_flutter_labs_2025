import 'package:favorites_list/screens/favorite_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isDarkMode = true;

  void switchTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      routes: {FavoriteScreen.id: (context) => FavoriteScreen(isDarkMode: isDarkMode, onSwitchTheme: switchTheme)},
      initialRoute: FavoriteScreen.id,
      debugShowCheckedModeBanner: false,
    );
  }
}
