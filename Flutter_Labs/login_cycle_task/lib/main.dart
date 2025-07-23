import 'package:flutter/material.dart';
import 'package:login_cycle_task/screens/forgot_password_screen.dart';
import 'package:login_cycle_task/screens/home_screen.dart';
import 'package:login_cycle_task/screens/multistep_screen.dart';
import 'package:login_cycle_task/screens/signup_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.routeName,
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        MultiStepScreen.routeName: (context) => MultiStepScreen(),
        ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
      },
    );
  }
}
