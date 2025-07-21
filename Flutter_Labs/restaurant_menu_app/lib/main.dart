import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_menu_app/core/theme.dart';
import 'package:restaurant_menu_app/screens/home.dart';

void main() {
  runApp(const RestaurantMenuApp());
}

class RestaurantMenuApp extends StatefulWidget {
  const RestaurantMenuApp({super.key});

  @override
  State<RestaurantMenuApp> createState() => _RestaurantMenuAppState();
}

class _RestaurantMenuAppState extends State<RestaurantMenuApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light 
          ? ThemeMode.dark 
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _themeMode,
          home: HomeScreen(onThemeToggle: _toggleTheme, themeMode: _themeMode),
        );
      },
    );
  }
}