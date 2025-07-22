import 'package:flutter/material.dart';

class SaveCancelButtons extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const SaveCancelButtons({
    super.key,
    required this.onSave,
    required this.onCancel,
  });

  void _confirmSave(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirm Save'),
        content: const Text('Are you sure you want to save changes?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onSave();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile saved')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => _confirmSave(context),
            child: const Text('Save'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            onPressed: onCancel,
            child: const Text('Cancel'),
          ),
        ),
      ],
    );
  }
}
