// screens/multistep_screen.dart
import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';
import '../widgets/step_indicator.dart';

class MultiStepScreen extends StatefulWidget {
  const MultiStepScreen({super.key});
  static const String routeName = 'MultiStepScreen';
  @override
  _MultiStepScreenState createState() => _MultiStepScreenState();
}

class _MultiStepScreenState extends State<MultiStepScreen> {
  int currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String password = '';

  void _nextStep() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (currentStep < 2) {
        setState(() {
          currentStep++;
        });
      }
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  void _submitForm() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Form submitted successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    print('Final Data - Name: $name, Email: $email, Password: $password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Multi-Step Form')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              StepIndicator(currentStep: currentStep),
              SizedBox(height: 32),

              Expanded(child: _buildStepContent()),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentStep > 0)
                    CustomButton(
                      text: 'Back',
                      onPressed: _previousStep,
                      color: Colors.grey,
                    )
                  else
                    SizedBox.shrink(),

                  if (currentStep < 2)
                    CustomButton(text: 'Next', onPressed: _nextStep)
                  else
                    CustomButton(text: 'Submit', onPressed: _submitForm),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return Column(
          children: [
            Text(
              'Personal Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: name,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name cannot be empty';
                }
                return null;
              },
              onSaved: (value) => name = value!,
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: email,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email cannot be empty';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email address with @ symbol';
                }
                return null;
              },
              onSaved: (value) => email = value!,
            ),
          ],
        );
      case 1:
        return Column(
          children: [
            Text(
              'Security',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: password,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password cannot be empty';
                }
                if (value.length < 8) {
                  return 'Password must contain at least 8 characters, including uppercase, lowercase, and a number';
                }
                if (!RegExp(
                  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)',
                ).hasMatch(value)) {
                  return 'Password must contain at least 8 characters, including uppercase, lowercase, and a number';
                }
                return null;
              },
              onSaved: (value) => password = value!,
            ),
          ],
        );
      case 2:
        return Column(
          children: [
            Text(
              'Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: $name', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    Text('Email: $email', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    Text(
                      'Password: ${'*' * password.length}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      default:
        return Container();
    }
  }
}
