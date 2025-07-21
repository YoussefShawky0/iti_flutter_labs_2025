import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_menu_app/core/constants.dart';
import 'package:restaurant_menu_app/widgets/category_tab_bar_widget.dart';
import 'package:restaurant_menu_app/widgets/menu_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    final filteredItems = selectedCategory == "All"
        ? menuItems
        : menuItems
              .where(
                (item) =>
                    item.category.toLowerCase() ==
                    selectedCategory.toLowerCase(),
              )
              .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("RESTAURANT MENU")),
      body: Column(
        children: [
          CategoryTabBar(
            selected: selectedCategory,
            onCategorySelected: (category) {
              setState(() => selectedCategory = category);
            },
            allMenuItems: menuItems,
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              itemCount: filteredItems.length,
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getCrossAxisCount(context),
                childAspectRatio: _getChildAspectRatio(context),
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
              ),
              itemBuilder: (context, index) {
                return MenuCard(item: filteredItems[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 3;
    if (width > 800) return 2;
    return 1;
  }

  double _getChildAspectRatio(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 2.5;
    if (width > 800) return 2.8;
    return 3.2;
  }
}
