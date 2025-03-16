import 'package:BandoBasta/Response/hall_booking_response.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:flutter/material.dart';

class BookingInfoMenu extends StatelessWidget {
  final MenuDetail menuDetail;
  final String menuName;
  final String price;

  const BookingInfoMenu({
    super.key,
    required this.menuDetail,
    required this.menuName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    // Get categorized menu
    Map<String, Map<String, List<FoodDetails>>> categorizedMenu =
        _getCategorizedMenu(menuDetail);

    return Scaffold(
      appBar: AppBar(
        title: Text(menuDetail.menuType ?? 'Food Menu'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: categorizedMenu.entries.map((categoryEntry) {
            return ExpansionTile(
              title: Text(
                categoryEntry.key,
                style: TextStyle(
                  fontSize: Dimensions.font10 * 1.8,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: categoryEntry.value.entries.map((subCategoryEntry) {
                return ExpansionTile(
                  title: Text(
                    subCategoryEntry.key,
                    style: TextStyle(
                      fontSize: Dimensions.font10 * 1.6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  children: subCategoryEntry.value.map((food) {
                    return ListTile(
                      title: Text(food.name ?? 'Unnamed'),
                    );
                  }).toList(),
                );
              }).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }

  Map<String, Map<String, List<FoodDetails>>> _getCategorizedMenu(
      MenuDetail menuDetail) {
    Map<String, Map<String, List<FoodDetails>>> menuMap = {};

    for (var food in menuDetail.foodDetails ?? []) {
      String category = food.foodCategory ?? 'General';
      String subCategory = food.foodSubCategory ?? 'Uncategorized';

      if (!menuMap.containsKey(category)) {
        menuMap[category] = {};
      }

      if (!menuMap[category]!.containsKey(subCategory)) {
        menuMap[category]![subCategory] = [];
      }

      menuMap[category]![subCategory]!.add(food);
    }

    return menuMap;
  }
}
