import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;

  const StepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: currentStep >= 0 ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '1. Personal Info',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: currentStep >= 0 ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: currentStep >= 1 ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '2. Security',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: currentStep >= 1 ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: currentStep >= 2 ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '3. Summary',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: currentStep >= 2 ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}