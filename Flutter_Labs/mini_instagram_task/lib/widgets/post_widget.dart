import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 8),
                ClipOval(
                  child: Image.asset(
                    'assets/art.jpg',
                    fit: BoxFit.cover,
                    height: 60,
                    width: 60,
                  ),
                ),
                const SizedBox(width: 15),
                const Text(
                  'User Name',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              height: 230,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset('assets/car.jpg', fit: BoxFit.fill),
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    // Handle like button press
                  },
                ),
                const Text('255 ', style: TextStyle(fontSize: 16)),
                IconButton(
                  icon: const Icon(
                    Icons.comment_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    // Handle comment button press
                  },
                ),
                const Text('25 ', style: TextStyle(fontSize: 16)),
                IconButton(
                  icon: const Icon(
                    Icons.send_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    // Handle send button press
                  },
                ),
                const Text('10', style: TextStyle(fontSize: 16)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Add a comment...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
