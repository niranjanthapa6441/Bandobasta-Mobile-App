import 'package:BandoBasta/Controller/venue_menu_controller.dart';
import 'package:BandoBasta/Response/venue_menu_response.dart';
import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:BandoBasta/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodMenuScreen extends StatefulWidget {
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
  _FoodMenuScreenState createState() => _FoodMenuScreenState();
}

class _FoodMenuScreenState extends State<FoodMenuScreen> {
  late Map<String, Map<String, Map<String, dynamic>>> menuMap;
  late Map<String, Map<String, List<bool>>> checkBoxStates;
  List<FoodDetail> selectedFoods = [];
  Map<String, String> validationMessages = {};

  @override
  void initState() {
    super.initState();
    menuMap = getCategorizedMenu(widget.menuDetail);
    checkBoxStates = initializeCheckBoxStates(menuMap);
  }

  Map<String, Map<String, List<bool>>> initializeCheckBoxStates(
      Map<String, Map<String, Map<String, dynamic>>> menuMap) {
    Map<String, Map<String, List<bool>>> states = {};
    menuMap.forEach((category, subCategories) {
      states[category] = {};
      subCategories.forEach((subCategory, subCategoryDetails) {
        states[category]![subCategory] =
            List.generate(subCategoryDetails['foods'].length, (_) => false);
      });
    });
    return states;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.menuName),
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

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Price: NPR ${widget.price}',
                    style: TextStyle(
                      fontSize: Dimensions.font10 * 2,
                      fontWeight: FontWeight.bold,
                      color: AppColors.themeColor,
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: menuMap.entries.map((categoryEntry) {
                        return ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          title: Text(
                            categoryEntry.key,
                            style: TextStyle(
                              fontSize: Dimensions.font10 * 1.6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          iconColor: AppColors.themeColor,
                          children: categoryEntry.value.entries
                              .map((subCategoryEntry) {
                            return ExpansionTile(
                              tilePadding: EdgeInsets.symmetric(horizontal: 10),
                              title: Row(
                                children: [
                                  Text(
                                    subCategoryEntry.key,
                                    style: TextStyle(
                                      fontSize: Dimensions.font10 * 1.4,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.width10),
                                  if (AppConstant.isSelectHallPackageSelected)
                                    Text(
                                      "(Select any ${subCategoryEntry.value['maxSelection']} from below)",
                                      style: TextStyle(
                                        fontSize: Dimensions.font10 * 1.2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                ],
                              ),
                              iconColor: AppColors.themeColor,
                              children: [
                                if (AppConstant
                                    .isSelectHallPackageSelected) ...[
                                  ...subCategoryEntry.value['foods']
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    int index = entry.key;
                                    FoodDetail item = entry.value;

                                    return CheckboxListTile(
                                      tileColor:
                                          checkBoxStates[categoryEntry.key]![
                                                  subCategoryEntry.key]![index]
                                              ? AppColors.themeColor
                                                  .withOpacity(0.1)
                                              : Colors.transparent,
                                      title: Text(item.name ?? 'Unnamed'),
                                      value: checkBoxStates[categoryEntry.key]![
                                          subCategoryEntry.key]![index],
                                      activeColor: AppColors.themeColor,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          int currentSelectionCount =
                                              checkBoxStates[
                                                          categoryEntry.key]![
                                                      subCategoryEntry.key]!
                                                  .where(
                                                      (isChecked) => isChecked)
                                                  .length;
                                          int maxSelection = subCategoryEntry
                                              .value['maxSelection'];

                                          if (value == true &&
                                              currentSelectionCount <
                                                  maxSelection) {
                                            checkBoxStates[categoryEntry.key]![
                                                subCategoryEntry
                                                    .key]![index] = true;
                                            selectedFoods.add(item);
                                          } else if (value == false) {
                                            checkBoxStates[categoryEntry.key]![
                                                subCategoryEntry
                                                    .key]![index] = false;
                                            selectedFoods.remove(item);
                                          } else {
                                            validationMessages[
                                                    subCategoryEntry.key] =
                                                'You can only select up to $maxSelection items from ${subCategoryEntry.key}.';
                                          }

                                          if (currentSelectionCount +
                                                  (value == true ? 1 : -1) >=
                                              maxSelection) {
                                            validationMessages
                                                .remove(subCategoryEntry.key);
                                          }
                                        });
                                      },
                                    );
                                  }).toList(),
                                ] else ...[
                                  ...subCategoryEntry.value['foods']
                                      .map((item) {
                                    return ListTile(
                                      title: Text(item.name ?? 'Unnamed'),
                                      trailing: Text('N/A'),
                                    );
                                  }).toList(),
                                ],
                                if (validationMessages
                                    .containsKey(subCategoryEntry.key))
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      validationMessages[subCategoryEntry.key]!,
                                      style: TextStyle(
                                          color: AppColors.themeColor),
                                    ),
                                  ),
                                SizedBox(height: Dimensions.height10),
                              ],
                            );
                          }).toList(),
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
                          bool isValid = true;

                          for (var categoryEntry in menuMap.entries) {
                            for (var subCategoryEntry
                                in categoryEntry.value.entries) {
                              int currentSelectionCount = checkBoxStates[
                                      categoryEntry.key]![subCategoryEntry.key]!
                                  .where((isChecked) => isChecked)
                                  .length;
                              int maxSelection =
                                  subCategoryEntry.value['maxSelection'];

                              if (currentSelectionCount < maxSelection) {
                                isValid = false;
                                validationMessages[subCategoryEntry.key] =
                                    'You must select at least $maxSelection items from ${subCategoryEntry.key}.';
                              } else {
                                // Clear any existing validation messages if selection is valid
                                validationMessages.remove(subCategoryEntry.key);
                              }
                            }
                          }

                          if (isValid) {
                            setState(() {
                              widget.menuDetail.foodDetails = selectedFoods;
                              AppConstant.menuDetail = widget.menuDetail;
                            });

                            Get.toNamed(RouteHelper.getAvailableDateTime());
                          } else {
                            setState(() {});
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.themeColor,
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
                SizedBox(height: Dimensions.height20),
              ],
            );
          },
        ),
      ),
    );
  }

  Map<String, Map<String, Map<String, dynamic>>> getCategorizedMenu(
      MenuDetail menuDetail) {
    Map<String, Map<String, Map<String, dynamic>>> menuMap = {};

    Map<String, int?> maxSelectionMap = {};
    for (var selectionDetail in menuDetail.menuItemSelectionRangeDetails!) {
      maxSelectionMap[selectionDetail.foodSubCategory!] =
          selectionDetail.maxSelection;
    }

    for (var food in menuDetail.foodDetails!) {
      String category = food.foodCategory!;
      String subCategory = food.foodSubCategory ?? 'General';

      if (!menuMap.containsKey(category)) {
        menuMap[category] = {};
      }

      if (!menuMap[category]!.containsKey(subCategory)) {
        menuMap[category]![subCategory] = {
          'foods': [],
          'maxSelection': maxSelectionMap[subCategory] ?? 0,
        };
      }

      menuMap[category]![subCategory]!['foods'].add(food);
    }

    return menuMap;
  }
}
