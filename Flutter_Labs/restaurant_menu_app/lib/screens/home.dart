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
  String selectedCategory = "Main";

  @override
  Widget build(BuildContext context) {
    final filteredItems = menuItems
        .where(
          (item) =>
              item.category.toLowerCase() == selectedCategory.toLowerCase(),
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
                crossAxisCount: 1.sw > 600 ? 2 : 1,
                childAspectRatio: 3,
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
}
