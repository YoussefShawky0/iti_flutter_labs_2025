import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final String id;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String category;
  final String difficulty;

  const Question({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.category,
    required this.difficulty,
  });

  String get correctAnswer => options[correctAnswerIndex];

  @override
  List<Object?> get props => [
    id,
    question,
    options,
    correctAnswerIndex,
    category,
    difficulty,
  ];

  Question copyWith({
    String? id,
    String? question,
    List<String>? options,
    int? correctAnswerIndex,
    String? category,
    String? difficulty,
  }) {
    return Question(
      id: id ?? this.id,
      question: question ?? this.question,
      options: options ?? this.options,
      correctAnswerIndex: correctAnswerIndex ?? this.correctAnswerIndex,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
    );
  }
}
