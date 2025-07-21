import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 14.sp),
    ),
  );
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 14.sp),
    ),
  );
}
