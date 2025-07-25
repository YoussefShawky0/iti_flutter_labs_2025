import 'package:equatable/equatable.dart';

class QuizResult extends Equatable {
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final int skippedAnswers;
  final double percentage;
  final String category;
  final Duration timeTaken;
  final List<QuestionResult> questionResults;

  const QuizResult({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.skippedAnswers,
    required this.percentage,
    required this.category,
    required this.timeTaken,
    required this.questionResults,
  });

  String get grade {
    if (percentage >= 90) return 'ممتاز';
    if (percentage >= 80) return 'جيد جداً';
    if (percentage >= 70) return 'جيد';
    if (percentage >= 60) return 'مقبول';
    return 'ضعيف';
  }

  String get gradeEmoji {
    if (percentage >= 90) return '🏆';
    if (percentage >= 80) return '🥈';
    if (percentage >= 70) return '🥉';
    if (percentage >= 60) return '👍';
    return '📚';
  }

  @override
  List<Object?> get props => [
    totalQuestions,
    correctAnswers,
    wrongAnswers,
    skippedAnswers,
    percentage,
    category,
    timeTaken,
    questionResults,
  ];
}

class QuestionResult extends Equatable {
  final String questionId;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final int? selectedAnswerIndex;
  final bool isCorrect;
  final bool isSkipped;

  const QuestionResult({
    required this.questionId,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    this.selectedAnswerIndex,
    required this.isCorrect,
    required this.isSkipped,
  });

  @override
  List<Object?> get props => [
    questionId,
    question,
    options,
    correctAnswerIndex,
    selectedAnswerIndex,
    isCorrect,
    isSkipped,
  ];
}
