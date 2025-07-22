import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController(
    text: 'Emma Johnson',
  );
  final TextEditingController _bioController = TextEditingController(
    text: 'Dreamer, thinker, and creator',
  );
  final TextEditingController _facebookController = TextEditingController(
    text: 'https://www.facebook.com',
  );
  final TextEditingController _twitterController = TextEditingController(
    text: 'https://www.twitter.com',
  );
  final TextEditingController _instagramController = TextEditingController(
    text: 'https://www.instagram.com',
  );

  bool _hasUnsavedChanges = false;
  String _profileImageType = 'default'; // default, assets/images/profile.png

  // Store original values for comparison
  final Map<String, String> _originalValues = {
    'name': 'Emma Johnson',
    'bio': 'Dreamer, thinker, and creator',
    'facebook': 'https://www.facebook.com',
    'twitter': 'https://www.twitter.com',
    'instagram': 'https://www.instagram.com',
  };

  @override
  void initState() {
    super.initState();
    // Add listeners to detect changes
    _nameController.addListener(_onTextChanged);
    _bioController.addListener(_onTextChanged);
    _facebookController.addListener(_onTextChanged);
    _twitterController.addListener(_onTextChanged);
    _instagramController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _hasUnsavedChanges =
          _nameController.text != _originalValues['name'] ||
          _bioController.text != _originalValues['bio'] ||
          _facebookController.text != _originalValues['facebook'] ||
          _twitterController.text != _originalValues['twitter'] ||
          _instagramController.text != _originalValues['instagram'];
    });
  }

  void _changeProfileImage() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Change Profile Picture',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.photo_library, color: Colors.white),
                ),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _profileImageType = 'assets/images/profile.png';
                    _hasUnsavedChanges = true;
                  });
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: const Text('Default'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _profileImageType = 'assets/images/default.png';
                    _hasUnsavedChanges = true;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Save Changes'),
            content: const Text(
              'Are you sure you want to save your profile changes?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Update original values
                  _originalValues['name'] = _nameController.text;
                  _originalValues['bio'] = _bioController.text;
                  _originalValues['facebook'] = _facebookController.text;
                  _originalValues['twitter'] = _twitterController.text;
                  _originalValues['instagram'] = _instagramController.text;

                  setState(() {
                    _hasUnsavedChanges = false;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile saved successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: const Text('Save'),
              ),
            ],
          );
        },
      );
    }
  }

  void _cancelChanges() {
    if (_hasUnsavedChanges) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Discard Changes'),
            content: const Text(
              'Are you sure you want to discard your changes?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Keep Editing'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Reset to original values
                  _nameController.text = _originalValues['name']!;
                  _bioController.text = _originalValues['bio']!;
                  _facebookController.text = _originalValues['facebook']!;
                  _twitterController.text = _originalValues['twitter']!;
                  _instagramController.text = _originalValues['instagram']!;

                  setState(() {
                    _hasUnsavedChanges = false;
                    _profileImageType = 'default';
                  });
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  'Discard',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  void _resetForm() {
    HapticFeedback.heavyImpact();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reset Form'),
          content: const Text(
            'Are you sure you want to reset the entire form?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Clear all fields
                _nameController.clear();
                _bioController.clear();
                _facebookController.clear();
                _twitterController.clear();
                _instagramController.clear();

                setState(() {
                  _hasUnsavedChanges = true;
                  _profileImageType = 'default';
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Form reset! Shake detected.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('Reset', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  String? _validateUrl(String? value) {
    if (value == null || value.isEmpty) return null;

    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );

    if (!urlRegex.hasMatch(value)) {
      return 'Please enter a valid URL';
    }
    return null;
  }

  Widget _buildProfileImage() {
    Widget imageWidget;

    if (_profileImageType.contains('profile.png')) {
      imageWidget = Image.asset(
        _profileImageType,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.green.shade100,
            child: const Icon(Icons.photo, size: 60, color: Colors.green),
          );
        },
      );
    } else if (_profileImageType.contains('default.png')) {
      imageWidget = Image.asset(
        _profileImageType,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey.shade200,
            child: const Icon(Icons.person, size: 60, color: Colors.grey),
          );
        },
      );
    } else {
      imageWidget = Image.asset(
        'assets/images/emma_johnson.png',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.pink.shade200, Colors.purple.shade200],
              ),
            ),
            child: const Center(
              child: Text(
                'EJ',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      );
    }

    return GestureDetector(
      onTap: _changeProfileImage,
      onLongPress: _changeProfileImage,
      child: Stack(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF6C63FF), width: 3),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6C63FF).withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipOval(child: imageWidget),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF6C63FF),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF6C63FF),
        elevation: 0,
        actions: [
          if (_hasUnsavedChanges)
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: const Icon(Icons.circle, color: Colors.orange, size: 12),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Image
                Center(child: _buildProfileImage()),
                const SizedBox(height: 32),

                // Name Field
                const Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF6C63FF),
                        width: 2,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Name is required';
                    }
                    if (value.trim().length < 2) {
                      return 'Name must be at least 2 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Bio Field
                const Text(
                  'Bio',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _bioController,
                  maxLines: 3,
                  maxLength: 150,
                  decoration: InputDecoration(
                    hintText: 'Tell us about yourself...',
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF6C63FF),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Social Media Section
                const Text(
                  'Social Media',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                ),
                const SizedBox(height: 16),

                // Facebook
                Row(
                  children: [
                    const Icon(Icons.facebook, color: Color(0xFF1877F2)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: _facebookController,
                        decoration: InputDecoration(
                          hintText: 'Facebook URL',
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF1877F2),
                              width: 2,
                            ),
                          ),
                        ),
                        validator: _validateUrl,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Twitter
                Row(
                  children: [
                    const Icon(Icons.alternate_email, color: Color(0xFF1DA1F2)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: _twitterController,
                        decoration: InputDecoration(
                          hintText: 'Twitter URL',
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFF1DA1F2),
                              width: 2,
                            ),
                          ),
                        ),
                        validator: _validateUrl,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Instagram
                Row(
                  children: [
                    const Icon(Icons.camera_alt, color: Color(0xFFE4405F)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: _instagramController,
                        decoration: InputDecoration(
                          hintText: 'Instagram URL',
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color(0xFFE4405F),
                              width: 2,
                            ),
                          ),
                        ),
                        validator: _validateUrl,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Shake to reset hint
                GestureDetector(
                  onLongPress: _resetForm,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.vibration,
                          size: 16,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Long press to reset form',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _hasUnsavedChanges ? _cancelChanges : null,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: BorderSide(
                    color: _hasUnsavedChanges ? Colors.red : Colors.grey,
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: _hasUnsavedChanges ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: _hasUnsavedChanges ? _saveProfile : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _facebookController.dispose();
    _twitterController.dispose();
    _instagramController.dispose();
    super.dispose();
  }
}
