import 'package:equatable/equatable.dart';

import '../models/question.dart';
import '../models/quiz_result.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}

class QuizCategorySelection extends QuizState {
  final List<String> availableCategories;
  final String selectedCategory;
  final int numberOfQuestions;

  const QuizCategorySelection({
    required this.availableCategories,
    required this.selectedCategory,
    required this.numberOfQuestions,
  });

  @override
  List<Object?> get props => [
    availableCategories,
    selectedCategory,
    numberOfQuestions,
  ];
}

class QuizLoading extends QuizState {}

class QuizInProgress extends QuizState {
  final List<Question> questions;
  final int currentQuestionIndex;
  final Map<String, int?> answers;
  final DateTime startTime;
  final Duration? timeLimit;

  const QuizInProgress({
    required this.questions,
    required this.currentQuestionIndex,
    required this.answers,
    required this.startTime,
    this.timeLimit,
  });

  Question get currentQuestion => questions[currentQuestionIndex];

  bool get isLastQuestion => currentQuestionIndex == questions.length - 1;

  bool get isFirstQuestion => currentQuestionIndex == 0;

  int get answeredQuestionsCount =>
      answers.values.where((answer) => answer != null).length;

  double get progress => (currentQuestionIndex + 1) / questions.length;

  Duration get elapsedTime => DateTime.now().difference(startTime);

  @override
  List<Object?> get props => [
    questions,
    currentQuestionIndex,
    answers,
    startTime,
    timeLimit,
  ];
}

class QuizCompleted extends QuizState {
  final QuizResult result;

  const QuizCompleted({required this.result});

  @override
  List<Object?> get props => [result];
}

class QuizError extends QuizState {
  final String message;

  const QuizError({required this.message});

  @override
  List<Object?> get props => [message];
}
