import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_menu_app/models/category_model.dart';
import 'package:restaurant_menu_app/models/menu_item_model.dart';

class CategoryTabBar extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onCategorySelected;
  final List<MenuItemModel> allMenuItems;

  const CategoryTabBar({
    super.key,
    required this.selected,
    required this.onCategorySelected,
    required this.allMenuItems,
  });

  @override
  Widget build(BuildContext context) {
    final categories = CategoryModel.fromMenuItems(allMenuItems);
    final allCategories = ['All', ...categories];

    return SizedBox(
      height: 50.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        itemCount: allCategories.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final category = allCategories[index];
          final isSelected = selected == category;

          return GestureDetector(
            onTap: () => onCategorySelected(category),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey[300],
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
