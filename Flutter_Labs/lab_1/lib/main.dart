import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: 300,
              height: 340,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 228, 225, 196),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person_pin, size: 50),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Youssef Shawky",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "15h",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      "Believe you can and you're halfway there. The only thing stopping you is yourself. - Thomas Edison",
                      style: TextStyle(
                        wordSpacing: 2,
                        fontSize: 16,
                        color: Color.fromARGB(255, 14, 14, 14),
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 100),
                    Divider(
                      color: const Color.fromARGB(255, 194, 157, 83),
                      thickness: 1,
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.favorite, color: Colors.red, size: 20),
                        const Text(
                          "100 Likes",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const Icon(Icons.comment, color: Colors.blue, size: 20),
                        const Text(
                          "50 Comments",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const Icon(Icons.share, color: Colors.green, size: 20),
                        const Text(
                          "Share",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
