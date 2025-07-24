import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/todo_cubit.dart';
import '../models/todo.dart';
import '../routes/app_routes.dart';
import '../utils/priority_helper.dart';
import '../widgets/add_todo_dialog.dart';

class TodoHomeScreen extends StatelessWidget {
  const TodoHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TO-DO LIST', style: TextStyle(color: Colors.white)),
        centerTitle: true,
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
          if (todos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.task_alt,
                    size: 80,
                    color: const Color.fromARGB(255, 137, 188, 182),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No todos yet. Add one!',
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 137, 188, 182),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return Container(
                margin: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: GestureDetector(
                    onTap: () {
                      context.read<TodoCubit>().toggleTodoCompletion(index);
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: todo.isCompleted
                            ? const Color.fromARGB(255, 137, 188, 182)
                            : Colors.transparent,
                        border: Border.all(
                          color: todo.isCompleted
                              ? const Color.fromARGB(255, 137, 188, 182)
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: todo.isCompleted
                          ? Icon(Icons.check, size: 16, color: Colors.white)
                          : null,
                    ),
                  ),
                  title: Text(
                    todo.text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      decoration: todo.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: todo.isCompleted
                          ? Colors.grey.shade500
                          : Colors.black,
                    ),
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: 4),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: PriorityHelper.getPriorityColor(
                        todo.priority,
                      ).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      PriorityHelper.getPriorityText(todo.priority),
                      style: TextStyle(
                        fontSize: 12,
                        color: PriorityHelper.getPriorityColor(todo.priority),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_up,
                          color: index > 0
                              ? const Color.fromARGB(255, 137, 188, 182)
                              : Colors.grey.shade300,
                        ),
                        onPressed: index > 0
                            ? () {
                                context.read<TodoCubit>().moveTodoUp(index);
                              }
                            : null,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: index < todos.length - 1
                              ? const Color.fromARGB(255, 137, 188, 182)
                              : Colors.grey.shade300,
                        ),
                        onPressed: index < todos.length - 1
                            ? () {
                                context.read<TodoCubit>().moveTodoDown(index);
                              }
                            : null,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                          color: Colors.red.shade400,
                        ),
                        onPressed: () {
                          context.read<TodoCubit>().removeTodo(index);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.details,
                      arguments: index,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 137, 188, 182),
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          showDialog(context: context, builder: (context) => AddTodoDialog());
        },
      ),
    );
  }
}
