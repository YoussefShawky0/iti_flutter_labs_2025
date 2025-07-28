import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/score_cubit.dart';
import '../services/storage_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? appVersion;
  int storageSize = 0;
  bool isFirstLaunch = false;

  @override
  void initState() {
    super.initState();
    _loadStorageInfo();
  }

  Future<void> _loadStorageInfo() async {
    final version = await StorageService.instance.getAppVersion();
    final size = await StorageService.instance.getStorageSize();
    final firstLaunch = await context.read<ScoreCubit>().isFirstLaunch();

    setState(() {
      appVersion = version;
      storageSize = size;
      isFirstLaunch = firstLaunch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings & Storage'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Information Section
            _buildSectionTitle('App Information'),
            _buildInfoCard([
              _buildInfoRow('App Version', appVersion ?? 'Unknown'),
              _buildInfoRow('First Launch', isFirstLaunch ? 'Yes' : 'No'),
              _buildInfoRow('Storage Used', '${storageSize} bytes'),
            ]),

            const SizedBox(height: 24),

            // Storage Management Section
            _buildSectionTitle('Storage Management'),
            _buildActionCard([
              _buildActionButton(
                'Refresh Storage Info',
                Icons.refresh,
                Colors.blue,
                _loadStorageInfo,
              ),
              const SizedBox(height: 12),
              _buildActionButton(
                'Clear All Data',
                Icons.delete_forever,
                Colors.red,
                _showClearAllDataDialog,
              ),
            ]),

            const SizedBox(height: 24),

            // About Section
            _buildSectionTitle('About'),
            _buildInfoCard([
              _buildInfoRow('Developer', 'Flutter Labs 2025'),
              _buildInfoRow(
                'Description',
                'Score Counter with SharedPreferences',
              ),
              _buildInfoRow('Features', 'Data Persistence, State Management'),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildActionCard(List<Widget> children) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(color: Colors.black54),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }

  void _showClearAllDataDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Clear All Data'),
        content: const Text(
          'This will permanently delete all players, scores, and app data. '
          'This action cannot be undone.\n\n'
          'Are you sure you want to continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              // Clear all data
              await context.read<ScoreCubit>().clearAllStoredData();

              Navigator.of(dialogContext).pop();

              // Show success message
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All data cleared successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );

                // Refresh storage info
                _loadStorageInfo();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}
