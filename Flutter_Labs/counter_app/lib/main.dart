import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/score_cubit.dart';
import 'screens/score_screen.dart';
import 'services/storage_service.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences/Storage Service
  await StorageService.instance.init();

  // Check if first launch and save app version
  final isFirstLaunch = await StorageService.instance.isFirstLaunch();
  await StorageService.instance.saveAppVersion('1.0.0');

  if (isFirstLaunch) {
    print('🎉 Welcome! This is your first time using the app.');
  } else {
    print('👋 Welcome back!');
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScoreCubit(),
      child: MaterialApp(
        title: 'Score Counter App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        home: const ScoreScreen(),
      ),
    );
  }
}
