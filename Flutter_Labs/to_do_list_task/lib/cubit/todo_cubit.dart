import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/todo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]);

  void addTodo(String text, Priority priority) {
    final newState = List<Todo>.from(state);
    newState.add(Todo(text, priority));
    emit(newState);
  }

  void removeTodo(int index) {
    final newState = List<Todo>.from(state);
    newState.removeAt(index);
    emit(newState);
  }

  void editTodo(int index, String newText, Priority newPriority) {
    final newState = List<Todo>.from(state);
    newState[index] = Todo(
      newText,
      newPriority,
      isCompleted: newState[index].isCompleted,
    );
    emit(newState);
  }

  void toggleTodoCompletion(int index) {
    final newState = List<Todo>.from(state);
    final currentTodo = newState[index];
    newState[index] = currentTodo.copyWith(
      isCompleted: !currentTodo.isCompleted,
    );
    emit(newState);
  }

  void clearAll() {
    emit([]);
  }

  void moveTodoUp(int index) {
    if (index > 0) {
      final newState = List<Todo>.from(state);
      final todo = newState.removeAt(index);
      newState.insert(index - 1, todo);
      emit(newState);
    }
  }

  void moveTodoDown(int index) {
    if (index < state.length - 1) {
      final newState = List<Todo>.from(state);
      final todo = newState.removeAt(index);
      newState.insert(index + 1, todo);
      emit(newState);
    }
  }
}
