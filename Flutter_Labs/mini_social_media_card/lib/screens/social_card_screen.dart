import 'package:flutter/material.dart';

import '../widgets/post_card.dart';

class SocialCardScreen extends StatefulWidget {
  const SocialCardScreen({super.key});

  @override
  State<SocialCardScreen> createState() => _SocialCardScreenState();
}

class _SocialCardScreenState extends State<SocialCardScreen> {
  bool isLiked = false;

  void handleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  void handleComment() {
    // Handle comment action
  }

  void handleShare() {
    // Handle share action
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Social Post",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 115, 137, 233),
        centerTitle: true,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFFFFF), Color.fromARGB(255, 152, 166, 232)],
          ),
        ),
        child: Center(
          child: PostCard(
            onLikePressed: handleLike,
            onCommentPressed: handleComment,
            onSharePressed: handleShare,
            isLiked: isLiked,
          ),
        ),
      ),
    );
  }
}
