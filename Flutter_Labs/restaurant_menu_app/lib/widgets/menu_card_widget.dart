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
      child: IntrinsicHeight(
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                bottomLeft: Radius.circular(12.r),
              ),
              child: Container(
                width: _getImageWidth(context),
                height: _getImageHeight(context),
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: item.image.isNotEmpty
                    ? Image.asset(
                        item.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: Icon(
                              Icons.restaurant,
                              size: 40.sp,
                              color: Colors.grey[600],
                            ),
                          );
                        },
                      )
                    : Icon(
                        Icons.restaurant,
                        size: 40.sp,
                        color: Colors.grey[600],
                      ),
              ),
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: _getTitleFontSize(context),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 4.h),

                    Text(
                      item.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                        fontSize: _getDescriptionFontSize(context),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 8.h),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        "\${item.price.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: _getPriceFontSize(context),
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(width: 8.w),
          ],
        ),
      ),
    );
  }

  double _getImageWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 120.w;
    if (width > 800) return 100.w;
    return 90.w;
  }

  double _getImageHeight(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 120.h;
    if (width > 800) return 100.h;
    return 90.h;
  }

  double _getTitleFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 20.sp;
    if (width > 800) return 18.sp;
    return 16.sp;
  }

  double _getDescriptionFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 16.sp;
    if (width > 800) return 14.sp;
    return 13.sp;
  }

  double _getPriceFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 18.sp;
    if (width > 800) return 16.sp;
    return 15.sp;
  }
}
