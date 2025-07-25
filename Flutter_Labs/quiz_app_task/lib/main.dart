import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cubits/quiz_cubit.dart';
import 'cubits/quiz_state.dart';
import 'screens/quiz_screen.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'كويز المعرفة الإسلامية',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: GoogleFonts.cairo().fontFamily,
        textTheme: GoogleFonts.cairoTextTheme(),
      ),
      home: BlocProvider(
        create: (context) => QuizCubit(),
        child: const QuizAppView(),
      ),
    );
  }
}

class QuizAppView extends StatelessWidget {
  const QuizAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) {
        if (state is QuizInitial) {
          return const WelcomeScreen();
        } else {
          return const QuizScreen();
        }
      },
    );
  }
}
