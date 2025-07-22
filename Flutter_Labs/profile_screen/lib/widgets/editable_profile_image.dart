import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditableProfileImage extends StatefulWidget {
  final String? imagePath;
  final void Function(String newPath) onImageSelected;

  const EditableProfileImage({
    super.key,
    required this.imagePath,
    required this.onImageSelected,
  });

  @override
  State<EditableProfileImage> createState() => _EditableProfileImageState();
}

class _EditableProfileImageState extends State<EditableProfileImage> {
  Uint8List? _webImageBytes;

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      if (kIsWeb) {
        final bytes = await picked.readAsBytes();
        setState(() {
          _webImageBytes = bytes;
        });
      } else {
        widget.onImageSelected(picked.path);
      }
    }
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text('Change Image'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Remove Image'),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _webImageBytes = null;
              });
              widget.onImageSelected('');
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;

    if (kIsWeb && _webImageBytes != null) {
      imageProvider = MemoryImage(_webImageBytes!);
    } else if (widget.imagePath != null && widget.imagePath!.isNotEmpty) {
      imageProvider = FileImage(File(widget.imagePath!));
    } else {
      imageProvider = const AssetImage('assets/images/default_avatar.jpg');
    }

    return GestureDetector(
      onTap: () => _pickImage(context),
      onLongPress: () => _showOptions(context),
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey[300],
        backgroundImage: imageProvider,
        child:
            (widget.imagePath == null || widget.imagePath!.isEmpty) &&
                _webImageBytes == null
            ? const Icon(Icons.person, size: 40, color: Colors.transparent)
            : null,
      ),
    );
  }
}
