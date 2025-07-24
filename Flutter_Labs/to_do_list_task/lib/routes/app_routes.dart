import 'package:flutter/material.dart';
import '../screens/todo_home_screen.dart';
import '../screens/todo_detail_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String details = '/details';
  
  static Map<String, WidgetBuilder> routes = {
    home: (context) => TodoHomeScreen(),
    details: (context) => TodoDetailScreen(),
  };
}