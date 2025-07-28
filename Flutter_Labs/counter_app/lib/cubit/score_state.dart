import 'package:equatable/equatable.dart';

import '../models/player_model.dart';

abstract class ScoreState extends Equatable {
  const ScoreState();

  @override
  List<Object?> get props => [];
}

class ScoreInitial extends ScoreState {
  const ScoreInitial();
}

class ScoreLoaded extends ScoreState {
  final List<Player> players;
  final bool isLoading;
  final String? errorMessage;

  const ScoreLoaded({
    required this.players,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [players, isLoading, errorMessage];

  ScoreLoaded copyWith({
    List<Player>? players,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ScoreLoaded(
      players: players ?? this.players,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ScoreLoading extends ScoreState {
  const ScoreLoading();
}

class ScoreError extends ScoreState {
  final String message;

  const ScoreError(this.message);

  @override
  List<Object?> get props => [message];
}
