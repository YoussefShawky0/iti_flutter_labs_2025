import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/todo_cubit.dart';
import '../models/todo.dart';
import '../utils/priority_helper.dart';

class AddTodoDialog extends StatefulWidget {
  @override
  _AddTodoDialogState createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final textController = TextEditingController();
  Priority selectedPriority = Priority.medium;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: textController,
            decoration: InputDecoration(
              labelText: 'Task name',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<Priority>(
            value: selectedPriority,
            decoration: InputDecoration(
              labelText: 'Priority Level',
              border: OutlineInputBorder(),
            ),
            onChanged: (Priority? value) {
              setState(() {
                selectedPriority = value!;
              });
            },
            items: Priority.values.map((Priority priority) {
              return DropdownMenuItem<Priority>(
                value: priority,
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: PriorityHelper.getPriorityColor(priority),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(PriorityHelper.getPriorityText(priority)),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('CANCEL'),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: Text('ADD'),
          onPressed: () {
            if (textController.text.isNotEmpty) {
              context.read<TodoCubit>().addTodo(
                textController.text,
                selectedPriority,
              );
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
