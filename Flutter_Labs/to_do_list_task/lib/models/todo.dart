class Todo {
  final String text;
  final Priority priority;
  final bool isCompleted;

  Todo(this.text, this.priority, {this.isCompleted = false});

  Todo copyWith({String? text, Priority? priority, bool? isCompleted}) {
    return Todo(
      text ?? this.text,
      priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() =>
      'Todo{text: $text, priority: $priority, isCompleted: $isCompleted}';
}

enum Priority { high, medium, low }
