import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_menu_app/core/constants.dart';
import 'package:restaurant_menu_app/widgets/category_tab_bar_widget.dart';
import 'package:restaurant_menu_app/widgets/menu_card_widget.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final ThemeMode themeMode;

  const HomeScreen({
    super.key,
    required this.onThemeToggle,
    required this.themeMode,
  });

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
      appBar: AppBar(
        title: const Text("RESTAURANT MENU"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: IconButton(
              icon: Icon(
                widget.themeMode == ThemeMode.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
                color: Theme.of(context).appBarTheme.foregroundColor,
              ),
              onPressed: widget.onThemeToggle,
              tooltip: 'Toggle Theme',
            ),
          ),
        ],
      ),
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                return GridView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: _getHorizontalPadding(constraints.maxWidth),
                    vertical: 12.h,
                  ),
                  itemCount: filteredItems.length,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _getCrossAxisCount(constraints.maxWidth),
                    childAspectRatio: _getChildAspectRatio(
                      constraints.maxWidth,
                    ),
                    crossAxisSpacing: _getSpacing(constraints.maxWidth),
                    mainAxisSpacing: 12.h,
                  ),
                  itemBuilder: (context, index) {
                    return MenuCard(
                      item: filteredItems[index],
                      screenWidth: constraints.maxWidth,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  int _getCrossAxisCount(double width) {
    if (width >= 1200) return 3;
    if (width >= 800) return 2;
    return 1;
  }

  double _getChildAspectRatio(double width) {
    if (width >= 1200) return 3.5;
    if (width >= 800) return 3.2;
    return 3.8;
  }

  double _getSpacing(double width) {
    if (width >= 1200) return 20.w;
    if (width >= 800) return 16.w;
    return 12.w;
  }

  double _getHorizontalPadding(double width) {
    if (width >= 1200) return 24.w;
    if (width >= 800) return 20.w;
    return 12.w;
  }
}
