import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_menu_app/models/menu_item_model.dart';

class MenuCard extends StatelessWidget {
  final MenuItemModel item;

  const MenuCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Row(
        children: [
          Image.asset(item.image, width: 100.w, height: 100.h, fit: BoxFit.cover),
          SizedBox(width: 12.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 4.h),
                  Text(item.description, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Text("\$${item.price}", style: TextStyle(fontSize: 16.sp)),
          ),
        ],
      ),
    );
  }
}
