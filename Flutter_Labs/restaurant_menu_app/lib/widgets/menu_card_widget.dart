import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_menu_app/models/menu_item_model.dart';

class MenuCard extends StatelessWidget {
  final MenuItemModel item;
  final double screenWidth;

  const MenuCard({super.key, required this.item, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: isDark ? 4 : 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Container(
        padding: EdgeInsets.all(_getCardPadding()),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Flexible(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  width: _getImageWidth(),
                  height: _getImageHeight(),
                  color: isDark ? Colors.grey[700] : Colors.grey[200],
                  child: item.image.isNotEmpty
                      ? Image.asset(
                          item.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.restaurant,
                              size: _getIconSize(),
                              color: isDark
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                            );
                          },
                        )
                      : Icon(
                          Icons.restaurant,
                          size: _getIconSize(),
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                ),
              ),
            ),

            SizedBox(width: _getContentSpacing()),

            // Content Section
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: _getTitleFontSize(),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: _getVerticalSpacing()),

                  // Description
                  Expanded(
                    child: Text(
                      item.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: _getDescriptionFontSize(),
                        color: isDark ? Colors.grey[300] : Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  SizedBox(height: _getDescriptionPriceSpacing()),

                  // Price
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: _getPricePadding(),
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(isDark ? 0.2 : 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      "\$${item.price.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: _getPriceFontSize(),
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Responsive helper methods
  double _getImageWidth() {
    if (screenWidth >= 1200) return 220.w; // Desktop
    if (screenWidth >= 1000) return 200.w; // iPad Pro - Very Large
    if (screenWidth >= 768) return 180.w; // Medium tablet - Large
    if (screenWidth >= 600) return 160.w; // Small tablet/iPad - Increased
    return 110.w; // Phone
  }

  double _getImageHeight() {
    if (screenWidth >= 1200) return 200.h; // Desktop
    if (screenWidth >= 1000) return 180.h; // iPad Pro - Very Large
    if (screenWidth >= 768) return 170.h; // Medium tablet - Large
    if (screenWidth >= 600) return 150.h; // Small tablet/iPad - Increased
    return 110.h; // Phone
  }

  double _getIconSize() {
    if (screenWidth >= 1200) return 70.sp; // Desktop
    if (screenWidth >= 1000) return 65.sp; // iPad Pro - Very Large
    if (screenWidth >= 768) return 60.sp; // Medium tablet - Large
    if (screenWidth >= 600) return 55.sp; // Small tablet/iPad - Increased
    return 42.sp; // Phone
  }

  double _getContentSpacing() {
    if (screenWidth >= 1200) return 28.w; // Desktop
    if (screenWidth >= 1000) return 25.w; // iPad Pro - Very Large
    if (screenWidth >= 768) return 22.w; // Medium tablet - Large
    if (screenWidth >= 600) return 18.w; // Small tablet/iPad - Increased
    return 12.w; // Phone
  }

  double _getTitleFontSize() {
    if (screenWidth >= 1200) return 28.sp; // Desktop
    if (screenWidth >= 1000) return 26.sp; // iPad Pro - Very Large
    if (screenWidth >= 768) return 24.sp; // Medium tablet - Large
    if (screenWidth >= 600) return 22.sp; // Small tablet/iPad - Increased
    return 18.sp; // Phone
  }

  double _getDescriptionFontSize() {
    if (screenWidth >= 1200) return 22.sp; // Desktop
    if (screenWidth >= 1000) return 20.sp; // iPad Pro - Very Large
    if (screenWidth >= 768) return 18.sp; // Medium tablet - Large
    if (screenWidth >= 600) return 17.sp; // Small tablet/iPad - Increased
    return 14.sp; // Phone
  }

  double _getPriceFontSize() {
    if (screenWidth >= 1200) return 24.sp; // Desktop
    if (screenWidth >= 1000) return 22.sp; // iPad Pro - Very Large
    if (screenWidth >= 768) return 20.sp; // Medium tablet - Large
    if (screenWidth >= 600) return 19.sp; // Small tablet/iPad - Increased
    return 16.sp; // Phone
  }

  double _getVerticalSpacing() {
    if (screenWidth >= 1200) return 12.h; // Desktop
    if (screenWidth >= 1000) return 10.h; // iPad Pro - Very Large
    if (screenWidth >= 768) return 8.h; // Medium tablet - Large
    if (screenWidth >= 600) return 7.h; // Small tablet/iPad - Increased
    return 4.h; // Phone
  }

  double _getPricePadding() {
    if (screenWidth >= 1200) return 12.h; // Desktop
    if (screenWidth >= 1000) return 10.h; // iPad Pro - Very Large
    if (screenWidth >= 768) return 9.h; // Medium tablet - Large
    if (screenWidth >= 600) return 8.h; // Small tablet/iPad - Increased
    return 5.h; // Phone
  }

  double _getCardPadding() {
    if (screenWidth >= 1200) return 20.w; // Desktop
    if (screenWidth >= 1000) return 18.w; // iPad Pro - Very Large
    if (screenWidth >= 768) return 16.w; // Medium tablet - Large
    if (screenWidth >= 600) return 14.w; // Small tablet/iPad - Increased
    return 8.w; // Phone
  }

  double _getDescriptionPriceSpacing() {
    if (screenWidth >= 1200) return 20.h; // Desktop
    if (screenWidth >= 1000) return 18.h; // iPad Pro - Very Large
    if (screenWidth >= 768) return 15.h; // Medium tablet - Large
    if (screenWidth >= 600) return 13.h; // Small tablet/iPad - Increased
    return 8.h; // Phone
  }
}
