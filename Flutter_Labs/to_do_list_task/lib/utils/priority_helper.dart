import 'package:flutter/material.dart';

import '../models/todo.dart';

class PriorityHelper {
  static Color getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.high:
        return Colors.red;
      case Priority.medium:
        return Colors.orange;
      case Priority.low:
        return Colors.green;
    }
  }

  static String getPriorityText(Priority priority) {
    switch (priority) {
      case Priority.high:
        return 'HIGH';
      case Priority.medium:
        return 'MEDIUM';
      case Priority.low:
        return 'LOW';
    }
  }
}
