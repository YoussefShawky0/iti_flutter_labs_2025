import 'menu_item_model.dart';

class CategoryModel {
  static String capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1).toLowerCase();

  static List<String> fromMenuItems(List<MenuItemModel> items) {
    final uniqueCategories = items
        .map((item) => capitalize(item.category))
        .toSet()
        .toList()
      ..sort();

    return uniqueCategories;
  }
}
