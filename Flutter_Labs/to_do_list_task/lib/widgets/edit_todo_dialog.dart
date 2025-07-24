import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/todo_cubit.dart';
import '../models/todo.dart';
import '../utils/priority_helper.dart';

class EditTodoDialog extends StatefulWidget {
  final Todo todo;
  final int index;

  const EditTodoDialog({Key? key, required this.todo, required this.index})
    : super(key: key);

  @override
  _EditTodoDialogState createState() => _EditTodoDialogState();
}

class _EditTodoDialogState extends State<EditTodoDialog> {
  late TextEditingController textController;
  late Priority selectedPriority;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.todo.text);
    selectedPriority = widget.todo.priority;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: textController,
            decoration: InputDecoration(
              labelText: 'Task name',
              border: OutlineInputBorder(),
            ),
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
          child: Text('SAVE'),
          onPressed: () {
            if (textController.text.isNotEmpty) {
              context.read<TodoCubit>().editTodo(
                widget.index,
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
