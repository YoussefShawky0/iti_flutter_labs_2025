import 'package:favorites_list/models/favorit_list_model.dart';
import 'package:favorites_list/widgets/favorit_card_widget.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({
    super.key,
    required this.isDarkMode,
    required this.onSwitchTheme,
  });

  static const String id = 'FavoriteScreen';
  final bool isDarkMode;
  final VoidCallback onSwitchTheme;

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites (${favorites.length})'),
        leading: const BackButton(),
        actions: [
          Switch(
            value: widget.isDarkMode,
            onChanged: (_) => widget.onSwitchTheme(),
          ),
        ],
      ),
      body: FavoritCard(),
    );
  }
}
