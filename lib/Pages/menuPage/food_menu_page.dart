import 'package:bandobasta/Controller/venue_menu_controller.dart';
import 'package:bandobasta/Response/venue_menu_response.dart';
import 'package:bandobasta/route_helper/route_helper.dart';
import 'package:bandobasta/utils/app_constants/app_constant.dart';
import 'package:bandobasta/utils/color/colors.dart';
import 'package:bandobasta/utils/dimensions/dimension.dart';
import 'package:bandobasta/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodMenuScreen extends StatelessWidget {
  final MenuDetail menuDetail;
  final String menuName;
  final String price;

  FoodMenuScreen({
    super.key,
    required this.menuDetail,
    required this.menuName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(menuName),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<VenueMenuController>(
          builder: (controller) {
            if (!controller.isLoaded) {
              return Center(child: CircularProgressIndicator());
            }
            List<Map<String, dynamic>> categorizedMenu =
                getCategorizedMenu(menuDetail);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Price: NPR $price',
                    style: TextStyle(
                      fontSize: Dimensions.font10 * 2,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: categorizedMenu.map((menuCategory) {
                        if (menuCategory['items'] == null ||
                            menuCategory['items'].isEmpty) {
                          return SizedBox();
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              menuCategory['category'],
                              style: TextStyle(
                                fontSize: Dimensions.font10 * 1.6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            ...menuCategory['items'].map((item) {
                              return ListTile(
                                title:
                                    Text(item.name), // Displaying the item name
                                trailing: Text(
                                  'N/A', // Placeholder for price (can be updated if needed)
                                ),
                              );
                            }).toList(),
                            Divider(),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
                if (AppConstant.isSelectHallPackageSelected)
                  Center(
                    child: Container(
                      width: Dimensions.width10 * 20,
                      height: Dimensions.height10 * 5,
                      child: ElevatedButton(
                        onPressed: () {
                          AppConstant.menuDetail = menuDetail;
                          Get.toNamed(RouteHelper.getCheckAvailabilityForm());
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.themeColor,
                        ),
                        child: Center(
                          child: BigText(
                            text: 'Select Menu',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  height: Dimensions.height20,
                )
              ],
            );
          },
        ),
      ),
    );
  }

  List<Map<String, dynamic>> getCategorizedMenu(MenuDetail menuDetail) {
    Map<String, List<FoodDetail>> menuMap = {};

    for (var food in menuDetail.foodDetails!) {
      String category = food.foodCategory!;
      String categoryName = categoryMapping[category] ?? category;

      if (!menuMap.containsKey(categoryName)) {
        menuMap[categoryName] = [];
      }

      menuMap[categoryName]!.add(food);
    }
    return menuMap.entries.map((entry) {
      return {
        'category': entry.key,
        'items': entry.value,
      };
    }).toList();
  }

  Map<String, String> categoryMapping = {
    'SALAD': 'Salad',
    'MAIN_COURSE_NON_VEGETARIAN': 'Main Course - Non-Vegetarian',
    'MAIN_COURSE_VEGETARIAN': 'Main Course - Vegetarian',
    'DESSERT': 'Dessert',
    'BREAD': 'Bread',
    'RICE': 'Rice',
    'SOUP': 'Soup',
    'DAL': 'Dal',
    'STARTERS': 'Starters',
    'BEVERAGE_NON_ALCOHOLIC': 'Beverages',
  };
}
