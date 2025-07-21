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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: _getTabBarHeight(context),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.grey.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: _getHorizontalPadding(context),
          vertical: _getVerticalPadding(context),
        ),
        itemCount: allCategories.length,
        separatorBuilder: (_, __) => SizedBox(width: _getItemSpacing(context)),
        itemBuilder: (context, index) {
          final category = allCategories[index];
          final isSelected = selected == category;

          return GestureDetector(
            onTap: () => onCategorySelected(category),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(
                horizontal: _getButtonHorizontalPadding(context),
                vertical: _getButtonVerticalPadding(context),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.r),
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : (isDark ? Colors.grey[800] : Colors.grey[200]),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.3),
                          offset: const Offset(0, 2),
                          blurRadius: 8,
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: _getFontSize(context),
                    color: isSelected
                        ? Colors.white
                        : (isDark ? Colors.white70 : Colors.black87),
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Responsive helper methods for tablet/iPad support
  double _getTabBarHeight(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 75.h; // Desktop
    if (width >= 1000) return 70.h; // iPad Pro - Increased
    if (width >= 600) return 65.h; // Small tablet/iPad - Increased
    return 55.h; // Phone
  }

  double _getHorizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 24.w; // Desktop
    if (width >= 1000) return 20.w; // iPad Pro
    if (width >= 600) return 18.w; // Small tablet/iPad
    return 16.w; // Phone
  }

  double _getVerticalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 12.h; // Desktop
    if (width >= 1000) return 11.h; // iPad Pro
    if (width >= 600) return 10.h; // Small tablet/iPad
    return 8.h; // Phone
  }

  double _getItemSpacing(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 16.w; // Desktop
    if (width >= 1000) return 14.w; // iPad Pro
    if (width >= 600) return 12.w; // Small tablet/iPad
    return 10.w; // Phone
  }

  double _getButtonHorizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 28.w; // Desktop
    if (width >= 1000) return 26.w; // iPad Pro - Increased
    if (width >= 600) return 24.w; // Small tablet/iPad - Increased
    return 20.w; // Phone
  }

  double _getButtonVerticalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 14.h; // Desktop
    if (width >= 1000) return 13.h; // iPad Pro - Increased
    if (width >= 600) return 12.h; // Small tablet/iPad - Increased
    return 10.h; // Phone
  }

  double _getFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return 19.sp; // Desktop
    if (width >= 1000) return 18.sp; // iPad Pro - Increased
    if (width >= 600) return 17.sp; // Small tablet/iPad - Increased
    return 15.sp; // Phone
  }
}
