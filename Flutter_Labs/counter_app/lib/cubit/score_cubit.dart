import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/player_model.dart';
import '../services/storage_service.dart';
import 'score_state.dart';

class ScoreCubit extends Cubit<ScoreState> {
  final StorageService _storageService = StorageService.instance;

  ScoreCubit() : super(const ScoreInitial()) {
    _loadPlayersFromStorage();
  }

  // Load players from StorageService
  Future<void> _loadPlayersFromStorage() async {
    try {
      final players = await _storageService.loadPlayers();
      emit(ScoreLoaded(players: _sortPlayers(players)));
    } catch (e) {
      emit(const ScoreLoaded(players: []));
    }
  }

  // Save players to StorageService
  Future<void> _savePlayersToStorage(List<Player> players) async {
    try {
      await _storageService.savePlayers(players);
    } catch (e) {
      // Handle save error silently
      print('Error saving players: $e');
    }
  }

  // Initialize with empty state
  void initializeEmpty() {
    emit(const ScoreLoaded(players: []));
  }

  // Add a new player
  void addPlayer(String name) {
    final currentState = state;

    if (currentState is ScoreLoaded) {
      final newPlayer = Player.create(name: name);
      final updatedPlayers = List<Player>.from(currentState.players)
        ..add(newPlayer);

      // Sort players by score (highest first) and emit new state
      _sortPlayersAndEmit(updatedPlayers);
    } else {
      // If not in loaded state, create new state with single player
      final newPlayer = Player.create(name: name);
      final players = [newPlayer];
      emit(ScoreLoaded(players: players));
      _savePlayersToStorage(players);
    }
  }

  // Remove player by ID
  void removePlayer(String playerId) {
    final currentState = state;

    if (currentState is ScoreLoaded) {
      final updatedPlayers = currentState.players
          .where((player) => player.id != playerId)
          .toList();

      _sortPlayersAndEmit(updatedPlayers);
    }
  }

  // Update player score (Task 4 requirement)
  void updatePlayerScore(String playerId, int newScore) {
    final currentState = state;

    if (currentState is ScoreLoaded) {
      final updatedPlayers = currentState.players.map((player) {
        if (player.id == playerId) {
          // Use Math.max to prevent negative scores
          return player.copyWith(score: newScore < 0 ? 0 : newScore);
        }
        return player;
      }).toList();

      _sortPlayersAndEmit(updatedPlayers);
    }
  }

  // Increment player score (Task 4 requirement)
  void incrementScore(String playerId) {
    final currentState = state;

    if (currentState is ScoreLoaded) {
      final player = currentState.players.firstWhere(
        (p) => p.id == playerId,
        orElse: () => throw ArgumentError('Player not found'),
      );
      updatePlayerScore(playerId, player.score + 1);
    }
  }

  // Decrement player score (Task 4 requirement)
  void decrementScore(String playerId) {
    final currentState = state;

    if (currentState is ScoreLoaded) {
      final player = currentState.players.firstWhere(
        (p) => p.id == playerId,
        orElse: () => throw ArgumentError('Player not found'),
      );
      // Decrease score by 1 (minimum 0)
      final newScore = player.score - 1;
      updatePlayerScore(playerId, newScore < 0 ? 0 : newScore);
    }
  }

  // Helper method to sort players by score (highest first) and emit new state
  void _sortPlayersAndEmit(List<Player> players) {
    final sortedPlayers = _sortPlayers(players);
    emit(ScoreLoaded(players: sortedPlayers));
    _savePlayersToStorage(sortedPlayers);
  }

  // Sort players helper method
  List<Player> _sortPlayers(List<Player> players) {
    final sortedList = List<Player>.from(players);
    sortedList.sort(
      (a, b) => b.score.compareTo(a.score),
    ); // Highest score first
    return sortedList;
  }

  // Get player by ID
  Player? getPlayerById(String playerId) {
    final currentState = state;
    if (currentState is ScoreLoaded) {
      try {
        return currentState.players.firstWhere((p) => p.id == playerId);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  // Reset all scores
  void resetAllScores() {
    final currentState = state;
    if (currentState is ScoreLoaded) {
      final resetPlayers = currentState.players
          .map((player) => player.copyWith(score: 0))
          .toList();
      emit(ScoreLoaded(players: resetPlayers));
      _savePlayersToStorage(resetPlayers);
    }
  }

  // Clear all players
  void clearAllPlayers() {
    emit(const ScoreLoaded(players: []));
    _savePlayersToStorage([]);
  }

  // Get storage information
  Future<int> getStorageSize() async {
    return await _storageService.getStorageSize();
  }

  // Clear all stored data
  Future<void> clearAllStoredData() async {
    await _storageService.clearAllData();
    emit(const ScoreLoaded(players: []));
  }

  // Check if this is first app launch
  Future<bool> isFirstLaunch() async {
    return await _storageService.isFirstLaunch();
  }
}
