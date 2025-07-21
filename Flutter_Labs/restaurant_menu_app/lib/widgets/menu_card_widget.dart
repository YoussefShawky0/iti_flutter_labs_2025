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
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Image Section
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                bottomLeft: Radius.circular(16.r),
              ),
              child: Container(
                width: _getImageWidth(),
                height: _getImageHeight(),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[700] : Colors.grey[200],
                ),
                child: item.image.isNotEmpty
                    ? Image.asset(
                        item.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: isDark ? Colors.grey[700] : Colors.grey[300],
                            child: Icon(
                              Icons.restaurant,
                              size: _getIconSize(),
                              color: isDark
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                            ),
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

            SizedBox(width: _getContentSpacing()),

            // Content Section
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: _getVerticalPadding(),
                  horizontal: 8.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
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

                    SizedBox(height: 5.h),

                    // Description
                    Text(
                      item.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: _getDescriptionFontSize(),
                        color: isDark ? Colors.grey[300] : Colors.grey[600],
                        height: 1.3.sp,
                      ),
                      maxLines: _getDescriptionMaxLines(),
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 12.h),

                    // Price
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
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
            ),

            SizedBox(width: 12.w),
          ],
        ),
      ),
    );
  }

  // Responsive helper methods
  double _getImageWidth() {
    if (screenWidth >= 1200) return 140.w;
    if (screenWidth >= 800) return 120.w;
    return 100.w;
  }

  double _getImageHeight() {
    if (screenWidth >= 1200) return 120.h;
    if (screenWidth >= 800) return 110.h;
    return 100.h;
  }

  double _getIconSize() {
    if (screenWidth >= 1200) return 50.sp;
    if (screenWidth >= 800) return 45.sp;
    return 40.sp;
  }

  double _getContentSpacing() {
    if (screenWidth >= 1200) return 16.w;
    if (screenWidth >= 800) return 14.w;
    return 12.w;
  }

  double _getVerticalPadding() {
    if (screenWidth >= 1200) return 16.h;
    if (screenWidth >= 800) return 14.h;
    return 12.h;
  }

  double _getTitleFontSize() {
    if (screenWidth >= 1200) return 22.sp;
    if (screenWidth >= 800) return 20.sp;
    return 18.sp;
  }

  double _getDescriptionFontSize() {
    if (screenWidth >= 1200) return 16.sp;
    if (screenWidth >= 800) return 15.sp;
    return 14.sp;
  }

  double _getPriceFontSize() {
    if (screenWidth >= 1200) return 18.sp;
    if (screenWidth >= 800) return 17.sp;
    return 16.sp;
  }

  int _getDescriptionMaxLines() {
    if (screenWidth >= 1200) return 3;
    if (screenWidth >= 800) return 2;
    return 2;
  }
}
