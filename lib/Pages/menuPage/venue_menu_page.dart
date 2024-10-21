import 'dart:ui';
import 'package:bandobasta/Controller/venue_menu_controller.dart';
import 'package:bandobasta/Response/venue_menu_response.dart';
import 'package:bandobasta/route_helper/route_helper.dart';
import 'package:bandobasta/utils/app_constants/app_constant.dart';
import 'package:bandobasta/utils/color/colors.dart';
import 'package:bandobasta/utils/dimensions/dimension.dart';
import 'package:bandobasta/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class VenueMenuPage extends StatefulWidget {
  final String imageURL;
  final String venueName;
  const VenueMenuPage(
      {super.key, required this.imageURL, required this.venueName});

  @override
  State<VenueMenuPage> createState() => _VenueMenuPageState();
}

class _VenueMenuPageState extends State<VenueMenuPage> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Get.find<VenueMenuController>().onClose();
    Get.find<VenueMenuController>().get();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _clear();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Get.find<VenueMenuController>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          iconSize: Dimensions.height10 * 3,
          onPressed: () {
            Navigator.pop(context);
            _clear();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            iconSize: Dimensions.height10 * 3,
            onPressed: () {},
          ),
          SizedBox(width: Dimensions.width10),
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.white),
            iconSize: Dimensions.height10 * 3,
            onPressed: () {},
          ),
          SizedBox(width: Dimensions.width10),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            iconSize: Dimensions.height10 * 3,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(
                  'assets/images/food.png',
                  height: Dimensions.height10 * 25,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                // Apply blur effect and transparent black overlay
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                ),

                // Circular Image
                Positioned(
                  left: Dimensions.width10 * 1.6,
                  bottom: -Dimensions.height10 * 4,
                  child: CircleAvatar(
                    radius: Dimensions.radius10 * 6,
                    backgroundImage: NetworkImage(widget.imageURL),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.height10 * 5),

            Padding(
              padding: EdgeInsets.all(Dimensions.width10 * 1.6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.venueName,
                    style: TextStyle(
                      fontSize: Dimensions.font10 * 2.4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star,
                          color: Colors.yellow, size: Dimensions.font10 * 1.6),
                      Text('4.5 (5k+ ratings)',
                          style: TextStyle(fontSize: Dimensions.font10 * 1.4)),
                    ],
                  ),
                ],
              ),
            ),
            if (AppConstant.isSelectHallPackageSelected)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width10 * 1.6,
                  vertical: Dimensions.height10 * 0.8,
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.height10 * 1.5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.themeColor, // Background color
                    borderRadius: BorderRadius.circular(
                        Dimensions.radius10 * 1.5), // Rounded corners
                  ),
                  child: Center(
                    child: BigText(
                      text: 'Select From Menus',
                      size: Dimensions.font10 * 1.9,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            else
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.width10 * 1.6,
                  vertical: Dimensions.height10 * 0.8,
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.height10 * 1.5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.themeColor, // Background color
                    borderRadius: BorderRadius.circular(
                        Dimensions.radius10 * 1.5), // Rounded corners
                  ),
                  child: Center(
                    child: BigText(
                      text: 'Available Menus',
                      size: Dimensions.font10 * 1.9,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            SizedBox(height: Dimensions.height20),

            // Venue cards section
            GetBuilder<VenueMenuController>(builder: (controller) {
              return GestureDetector(
                child: controller.isLoaded
                    ? Container(
                        height: Dimensions.height10 * 55,
                        padding: EdgeInsets.only(bottom: Dimensions.height20),
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.zero,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: controller.venueMenus.length + 1,
                          itemBuilder: (context, index) {
                            if (index == controller.venueMenus.length &&
                                index < controller.totalElements) {
                              return _buildSingleLoadingIndicator();
                            } else if (index >= controller.totalElements) {
                              return Container();
                            }
                            return buildMenuCard(controller.venueMenus[index],
                                index, controller.menuCategoryCount);
                          },
                        ),
                      )
                    : _buildLoadingIndicator(),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildMenuCard(MenuDetail menuDetail, int index,
      Map<String, Map<String, int>> menuCategoryCounts) {
    Map<String, int>? countsForCategory = menuCategoryCounts[menuDetail.id];

    return Padding(
      padding: EdgeInsets.all(Dimensions.height10 * 0.8),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(Dimensions.height10 * 1.6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(menuDetail.menuType! + " Menu",
                  style: TextStyle(
                      fontSize: Dimensions.font10 * 1.8,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: Dimensions.height10 * 0.5),
              Text(menuDetail.price!.toString(),
                  style: TextStyle(
                      fontSize: Dimensions.font10 * 1.6,
                      color: AppColors.themeColor)),
              SizedBox(height: Dimensions.height10),
              if (countsForCategory != null)
                ...countsForCategory.entries.map((entry) {
                  return buildMenuRow(entry.key, entry.value);
                }).toList(),
              SizedBox(height: Dimensions.height10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    AppConstant.menuIndex = index;
                    Get.toNamed(
                        RouteHelper.getMenuDetail("${menuDetail.menuType} Menu",
                            menuDetail.price.toString()),
                        arguments: menuDetail);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.themeColor,
                    padding:
                        EdgeInsets.symmetric(vertical: Dimensions.height10),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10 * 0.8)),
                  ),
                  child: BigText(
                    text: 'View Menu',
                    color: Colors.white,
                    size: Dimensions.font15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuRow(String label, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(value(label)),
        Text(count.toString()),
      ],
    );
  }

  void _clear() {
    AppConstant.page = 1;
    AppConstant.venueName = "";
    AppConstant.venueImageURL = "";
    Get.find<VenueMenuController>().onClose();
    Get.find<VenueMenuController>().get();
  }

  Widget _buildLoadingIndicator() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: true,
      child: ListView.builder(
        itemCount: 6,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, __) {
          return Padding(
            padding: EdgeInsets.all(Dimensions.height10 * 0.8),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(Dimensions.height10 * 1.6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: Dimensions.height10 * 2.4,
                      color: Colors.white,
                    ),
                    SizedBox(height: Dimensions.height10 * 0.5),
                    Container(
                      height: Dimensions.height10 * 2.2,
                      color: Colors.white,
                    ),
                    SizedBox(height: Dimensions.height10),
                    Container(
                      height: Dimensions.height10 * 1.8,
                      color: Colors.white,
                    ),
                    SizedBox(height: Dimensions.height10 * 0.8),
                    Container(
                      height: Dimensions.height10 * 1.8,
                      color: Colors.white,
                    ),
                    SizedBox(height: Dimensions.height10 * 0.8),
                    Container(
                      height: Dimensions.height10 * 1.8,
                      color: Colors.white,
                    ),
                    SizedBox(height: Dimensions.height10 * 0.8),
                    Container(
                      height: Dimensions.height10 * 1.8,
                      color: Colors.white,
                    ),
                    SizedBox(height: Dimensions.height10 * 0.8),
                    Container(
                      height: Dimensions.height10 * 1.8,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSingleLoadingIndicator() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.height10 * 1.5),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.themeColor),
        ),
      ),
    );
  }

  String value(String value) {
    switch (value) {
      case "STARTERS":
        return "Starters";
      case "SOUP":
        return "Soup";
      case "SALAD":
        return "Salad";
      case "MAIN_COURSE_VEGETARIAN":
        return "Main Course - Vegetarian";
      case "MAIN_COURSE_NON_VEGETARIAN":
        return "Main Course - Non-Vegetarian";
      case "SIDE_DISH":
        return "Side Dish";
      case "BREAD":
        return "Bread";
      case "RICE":
        return "Rice";
      case "DAL":
        return "Dal";
      case "DESSERT":
        return "Dessert";
      case "BEVERAGE_NON_ALCOHOLIC":
        return "Non-Alcoholic Beverages";
      case "BEVERAGE_ALCOHOLIC":
        return "Alcoholic Beverages";
      case "SPECIALTY_ITEM":
        return "Specialty Item";
      case "CONDIMENT":
        return "Condiments";
      case "LIVE_STATION":
        return "Live Station";
      default:
        return "";
    }
  }
}
