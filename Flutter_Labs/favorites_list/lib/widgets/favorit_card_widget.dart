
import 'package:favorites_list/models/favorit_list_model.dart';
import 'package:flutter/material.dart';

class FavoritCard extends StatelessWidget {
  const FavoritCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final item = favorites[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16), // مسافة أكبر بين الكروت
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 6,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 16,
            ),
            leading: CircleAvatar(
              radius: 40, // أكبر من 28
              backgroundImage: AssetImage(item.image),
            ),
            title: Text(
              item.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20, // كبر الخط
              ),
            ),
            subtitle: Text(
              item.subtitle,
              style: const TextStyle(fontSize: 16),
            ),
            trailing: const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 30, // كبر القلب
            ),
          ),
        );
      },
    );
  }
}
