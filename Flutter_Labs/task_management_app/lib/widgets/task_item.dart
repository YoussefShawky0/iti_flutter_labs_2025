import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final void Function(String) onToggle;
  final void Function(String) onDelete;

  const TaskItem({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: task.isDone
                ? [Colors.green.shade100, Colors.green.shade50]
                : [Colors.white, Colors.indigo.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.isDone ? TextDecoration.lineThrough : null,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: task.isDone ? Colors.grey.shade600 : Colors.grey.shade800,
            ),
          ),
          leading: Checkbox(
            value: task.isDone,
            onChanged: (_) => onToggle(task.id),
            activeColor: Colors.green.shade600,
            checkColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: Colors.red.shade400,
              size: 24,
            ),
            onPressed: () => onDelete(task.id),
            splashRadius: 20,
          ),
        ),
      ),
    );
  }
}
