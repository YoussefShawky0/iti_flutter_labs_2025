import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/question.dart';
import '../models/quiz_result.dart';
import '../quiz_data.dart';
import 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitial());

  void startQuiz() {
    try {
      final categories = QuizData.getCategories();
      emit(
        QuizCategorySelection(
          availableCategories: categories,
          selectedCategory: categories.first,
          numberOfQuestions: 10,
        ),
      );
    } catch (e) {
      emit(QuizError(message: 'خطأ في تحميل الفئات: $e'));
    }
  }

  void selectCategory(String category) {
    final currentState = state;
    if (currentState is QuizCategorySelection) {
      emit(
        QuizCategorySelection(
          availableCategories: currentState.availableCategories,
          selectedCategory: category,
          numberOfQuestions: currentState.numberOfQuestions,
        ),
      );
    }
  }

  void setNumberOfQuestions(int count) {
    final currentState = state;
    if (currentState is QuizCategorySelection) {
      emit(
        QuizCategorySelection(
          availableCategories: currentState.availableCategories,
          selectedCategory: currentState.selectedCategory,
          numberOfQuestions: count,
        ),
      );
    }
  }

  void beginQuiz({bool shuffleQuestions = true}) {
    final currentState = state;
    if (currentState is! QuizCategorySelection) return;

    emit(QuizLoading());

    try {
      List<Question> questions = QuizData.getQuestionsByCategory(
        currentState.selectedCategory,
      );

      if (shuffleQuestions) {
        questions.shuffle();
      }

      if (questions.length > currentState.numberOfQuestions) {
        questions = questions.take(currentState.numberOfQuestions).toList();
      }

      if (questions.isEmpty) {
        emit(const QuizError(message: 'لا توجد أسئلة متاحة في هذه الفئة'));
        return;
      }

      emit(
        QuizInProgress(
          questions: questions,
          currentQuestionIndex: 0,
          answers: {},
          startTime: DateTime.now(),
        ),
      );
    } catch (e) {
      emit(QuizError(message: 'خطأ في بدء الكويز: $e'));
    }
  }

  void answerQuestion(int answerIndex) {
    final currentState = state;
    if (currentState is! QuizInProgress) return;

    final currentQuestion = currentState.currentQuestion;
    final updatedAnswers = Map<String, int?>.from(currentState.answers);
    updatedAnswers[currentQuestion.id] = answerIndex;

    emit(
      QuizInProgress(
        questions: currentState.questions,
        currentQuestionIndex: currentState.currentQuestionIndex,
        answers: updatedAnswers,
        startTime: currentState.startTime,
        timeLimit: currentState.timeLimit,
      ),
    );
  }

  void nextQuestion() {
    final currentState = state;
    if (currentState is! QuizInProgress) return;

    if (currentState.isLastQuestion) {
      _completeQuiz();
    } else {
      emit(
        QuizInProgress(
          questions: currentState.questions,
          currentQuestionIndex: currentState.currentQuestionIndex + 1,
          answers: currentState.answers,
          startTime: currentState.startTime,
          timeLimit: currentState.timeLimit,
        ),
      );
    }
  }

  void previousQuestion() {
    final currentState = state;
    if (currentState is! QuizInProgress) return;

    if (!currentState.isFirstQuestion) {
      emit(
        QuizInProgress(
          questions: currentState.questions,
          currentQuestionIndex: currentState.currentQuestionIndex - 1,
          answers: currentState.answers,
          startTime: currentState.startTime,
          timeLimit: currentState.timeLimit,
        ),
      );
    }
  }

  void skipQuestion() {
    final currentState = state;
    if (currentState is! QuizInProgress) return;

    final currentQuestion = currentState.currentQuestion;
    final updatedAnswers = Map<String, int?>.from(currentState.answers);
    updatedAnswers[currentQuestion.id] = null;

    emit(
      QuizInProgress(
        questions: currentState.questions,
        currentQuestionIndex: currentState.currentQuestionIndex,
        answers: updatedAnswers,
        startTime: currentState.startTime,
        timeLimit: currentState.timeLimit,
      ),
    );

    nextQuestion();
  }

  void goToQuestion(int questionIndex) {
    final currentState = state;
    if (currentState is! QuizInProgress) return;

    if (questionIndex >= 0 && questionIndex < currentState.questions.length) {
      emit(
        QuizInProgress(
          questions: currentState.questions,
          currentQuestionIndex: questionIndex,
          answers: currentState.answers,
          startTime: currentState.startTime,
          timeLimit: currentState.timeLimit,
        ),
      );
    }
  }

  void _completeQuiz() {
    final currentState = state;
    if (currentState is! QuizInProgress) return;

    try {
      final endTime = DateTime.now();
      final timeTaken = endTime.difference(currentState.startTime);

      int correctAnswers = 0;
      int wrongAnswers = 0;
      int skippedAnswers = 0;

      final questionResults = <QuestionResult>[];

      for (final question in currentState.questions) {
        final selectedAnswer = currentState.answers[question.id];

        if (selectedAnswer == null) {
          skippedAnswers++;
          questionResults.add(
            QuestionResult(
              questionId: question.id,
              question: question.question,
              options: question.options,
              correctAnswerIndex: question.correctAnswerIndex,
              selectedAnswerIndex: null,
              isCorrect: false,
              isSkipped: true,
            ),
          );
        } else if (selectedAnswer == question.correctAnswerIndex) {
          correctAnswers++;
          questionResults.add(
            QuestionResult(
              questionId: question.id,
              question: question.question,
              options: question.options,
              correctAnswerIndex: question.correctAnswerIndex,
              selectedAnswerIndex: selectedAnswer,
              isCorrect: true,
              isSkipped: false,
            ),
          );
        } else {
          wrongAnswers++;
          questionResults.add(
            QuestionResult(
              questionId: question.id,
              question: question.question,
              options: question.options,
              correctAnswerIndex: question.correctAnswerIndex,
              selectedAnswerIndex: selectedAnswer,
              isCorrect: false,
              isSkipped: false,
            ),
          );
        }
      }

      final totalQuestions = currentState.questions.length;
      final percentage = (correctAnswers / totalQuestions) * 100;

      final result = QuizResult(
        totalQuestions: totalQuestions,
        correctAnswers: correctAnswers,
        wrongAnswers: wrongAnswers,
        skippedAnswers: skippedAnswers,
        percentage: percentage,
        category: currentState.questions.first.category,
        timeTaken: timeTaken,
        questionResults: questionResults,
      );

      emit(QuizCompleted(result: result));
    } catch (e) {
      emit(QuizError(message: 'خطأ في حساب النتائج: $e'));
    }
  }

  void restartQuiz() {
    startQuiz();
  }

  void resetQuiz() {
    emit(QuizInitial());
  }
}
