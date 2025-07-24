import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/todo_cubit.dart';
import '../models/todo.dart';
import '../utils/priority_helper.dart';
import '../widgets/edit_todo_dialog.dart';

class TodoDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final index = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
        backgroundColor: const Color.fromARGB(255, 137, 188, 182),
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(
        255,
        137,
        188,
        182,
      ).withOpacity(0.1),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          if (index >= todos.length) {
            return Center(child: Text('Task not found!'));
          }

          final todo = todos[index];

          return Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.task_alt,
                        size: 64,
                        color: const Color.fromARGB(255, 137, 188, 182),
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Task:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        todo.text,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: PriorityHelper.getPriorityColor(
                            todo.priority,
                          ).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${PriorityHelper.getPriorityText(todo.priority)} PRIORITY',
                          style: TextStyle(
                            fontSize: 14,
                            color: PriorityHelper.getPriorityColor(
                              todo.priority,
                            ),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            icon: Icon(Icons.edit),
                            label: Text('Edit'),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    EditTodoDialog(todo: todo, index: index),
                              );
                            },
                          ),
                          OutlinedButton.icon(
                            icon: Icon(Icons.arrow_back),
                            label: Text('Go Back'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
