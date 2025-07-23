import 'package:flutter/material.dart';
import 'package:login_cycle_task/screens/forgot_password_screen.dart';
import 'package:login_cycle_task/screens/multistep_screen.dart';
import 'package:login_cycle_task/screens/signup_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Screen',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.brown.shade50, Colors.brown.shade100],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.account_circle, size: 80, color: Colors.brown),
                SizedBox(height: 40),
                Text(
                  'Welcome to Login Cycle',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown.shade800,
                  ),
                ),
                SizedBox(height: 50),
                _buildCustomButton(
                  context,
                  'Sign-Up Form',
                  Icons.person_add,
                  () => Navigator.pushNamed(context, SignUpScreen.routeName),
                ),
                SizedBox(height: 20),
                _buildCustomButton(
                  context,
                  'Multi-Step Form',
                  Icons.format_list_numbered,
                  () => Navigator.pushNamed(context, MultiStepScreen.routeName),
                ),
                SizedBox(height: 20),
                _buildCustomButton(
                  context,
                  'Forgot Password',
                  Icons.lock_reset,
                  () => Navigator.pushNamed(
                    context,
                    ForgotPasswordScreen.routeName,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomButton(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Container(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.brown,
          foregroundColor: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
