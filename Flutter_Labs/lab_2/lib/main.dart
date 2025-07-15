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
        backgroundColor: const Color(0xFFE8F0F8), // خلفية ناعمة للتطبيق
        appBar: AppBar(
          title: const Text(
            'Lab_2 (Youssef Shawky)',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xFF1565C0), // أزرق جذاب
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 380,
              width: 320,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F9FF), // خلفية الكارت فاتحة وأنيقة
                border: Border.all(color: const Color(0xFF1565C0), width: 2),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.10),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Stylish Backpack',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.star, color: Colors.amber, size: 28),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTA5L3Jhd3BpeGVsX29mZmljZV8xOV9waG90b19vZl90ZWVuX3NjaG9vbF9iYWNrcGFja19pc29sYXRlZF9vbl93aF9iYzY3OTMwNC04ZTY1LTQzNmUtYWE3ZS02ZjUyZWVkYzkwN2EucG5n.png',
                      width: 170,
                      height: 170,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Price: ',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        '\$59.99',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(width: 15),
                      Icon(Icons.favorite, color: Colors.redAccent, size: 28),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Action when button is pressed
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xFF1565C0,
                      ), // نفس لون الـ appBar
                      foregroundColor: Colors.white,
                      minimumSize: const Size(200, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    child: const Text('Add to Cart'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
