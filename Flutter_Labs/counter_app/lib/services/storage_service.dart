import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/player_model.dart';

class StorageService {
  static const String _playersKey = 'players_data';
  static const String _appVersionKey = 'app_version';
  static const String _firstLaunchKey = 'first_launch';

  static StorageService? _instance;
  SharedPreferences? _prefs;

  StorageService._();

  static StorageService get instance {
    _instance ??= StorageService._();
    return _instance!;
  }

  // Initialize SharedPreferences
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Save players list to storage
  Future<bool> savePlayers(List<Player> players) async {
    try {
      if (_prefs == null) await init();

      final playersJson = json.encode(
        players.map((player) => player.toJson()).toList(),
      );

      return await _prefs!.setString(_playersKey, playersJson);
    } catch (e) {
      print('Error saving players: $e');
      return false;
    }
  }

  // Load players list from storage
  Future<List<Player>> loadPlayers() async {
    try {
      if (_prefs == null) await init();

      final playersJson = _prefs!.getString(_playersKey);

      if (playersJson != null && playersJson.isNotEmpty) {
        final List<dynamic> playersList = json.decode(playersJson);
        return playersList
            .map((json) => Player.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      return [];
    } catch (e) {
      print('Error loading players: $e');
      return [];
    }
  }

  // Clear all players data
  Future<bool> clearPlayers() async {
    try {
      if (_prefs == null) await init();
      return await _prefs!.remove(_playersKey);
    } catch (e) {
      print('Error clearing players: $e');
      return false;
    }
  }

  // Check if this is first app launch
  Future<bool> isFirstLaunch() async {
    if (_prefs == null) await init();

    final isFirst = _prefs!.getBool(_firstLaunchKey) ?? true;
    if (isFirst) {
      await _prefs!.setBool(_firstLaunchKey, false);
    }
    return isFirst;
  }

  // Save app version
  Future<bool> saveAppVersion(String version) async {
    try {
      if (_prefs == null) await init();
      return await _prefs!.setString(_appVersionKey, version);
    } catch (e) {
      print('Error saving app version: $e');
      return false;
    }
  }

  // Get app version
  Future<String?> getAppVersion() async {
    try {
      if (_prefs == null) await init();
      return _prefs!.getString(_appVersionKey);
    } catch (e) {
      print('Error getting app version: $e');
      return null;
    }
  }

  // Get total storage size (approximate)
  Future<int> getStorageSize() async {
    try {
      if (_prefs == null) await init();

      final keys = _prefs!.getKeys();
      int totalSize = 0;

      for (String key in keys) {
        final value = _prefs!.get(key);
        if (value is String) {
          totalSize += value.length;
        }
      }

      return totalSize;
    } catch (e) {
      print('Error calculating storage size: $e');
      return 0;
    }
  }

  // Clear all storage data
  Future<bool> clearAllData() async {
    try {
      if (_prefs == null) await init();
      return await _prefs!.clear();
    } catch (e) {
      print('Error clearing all data: $e');
      return false;
    }
  }
}
