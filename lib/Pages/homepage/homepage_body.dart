import 'package:bandobasta/Model/food.dart';
import 'package:bandobasta/Model/restaurant.dart';
import 'package:bandobasta/widgets/app_button.dart';
import 'package:bandobasta/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../route_helper/route_helper.dart';
import '../../utils/Color/colors.dart';
import '../../utils/app_constants/app_constant.dart';
import '../../utils/dimensions/dimension.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  PageController pageController = PageController(viewportFraction: 0.9);
  ScrollController scrollController = ScrollController();
  var _currentPageValue = 0.0;
  var _currentPosition = 0.0;

  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
    scrollController.addListener(() {
      setState(() {
        _currentPosition = scrollController.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: Dimensions.width20,
          ),
          child: Row(
            children: [BigText(text: "Services")],
          ),
        ),
        // Static list for services
        GestureDetector(
          child: Container(
            height: Dimensions.height10 * 35,
            child: PageView.builder(
                controller: pageController,
                itemCount: 6, // Static number of food items
                itemBuilder: (context, index) {
                  // Static food data
                  List<Service> services = [
                    Service(
                        name: 'Wedding',
                        description: 'Find the perfect venue for your wedding.',
                        imagePath: 'assets/images/wedding.png'),
                    Service(
                        name: 'Henna Artist',
                        description: 'Beautiful henna designs for your events.',
                        imagePath: 'assets/images/henna.png'),
                    Service(
                        name: 'Photographer',
                        description: 'Capture your special moments with professional photographers.',
                        imagePath: 'assets/images/pasta.png'),
                    Service(
                        name: 'DJ Service',
                        description: 'Get the party started with one of the best DJs.',
                        imagePath: 'assets/images/pasta.png'),
                    Service(
                        name: 'Catering Service',
                        description: 'Delicious services for you events and gatherings.',
                        imagePath: 'assets/images/pasta.png'),
                    Service(
                        name: 'Event Planner',
                        description: 'Professional Planners for your events.',
                        imagePath: 'assets/images/pasta.png'),
                  ];
                  return _buildPageItem(index, services[index]);
                }),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: Dimensions.width20,
          ),
          child: Row(
            children: [BigText(text: "Popular Venues")],
          ),
          height: Dimensions.height40,
        ),
        // Static list for restaurants
        GestureDetector(
          child: Container(
            height: Dimensions.height10 * 130,
            child: ListView.builder(
                controller: scrollController,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3, // Static number of restaurants
                itemBuilder: (context, index) {
                  // Static restaurant data
                  List<Restaurant> restaurants = [
                    Restaurant(
                        name: 'Fast Food Place',
                        address: '123 Main St',
                        imagePath: 'assets/images/restaurant1.png'),
                    Restaurant(
                        name: 'Italian Bistro',
                        address: '456 Elm St',
                        imagePath: 'assets/images/restaurant2.png'),
                    Restaurant(
                        name: 'Pasta House',
                        address: '789 Oak St',
                        imagePath: 'assets/images/restaurant3.png'),
                  ];
                  return _buildPopularRestaurant(index, restaurants[index]);
                }),
          ),
        ),
      ],
    );
  }

  Widget _buildPageItem(int index, Service services) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var _currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var _currTrans = _height * (1 - _currScale) / 2;
      var matrix = Matrix4.diagonal3Values(1, _currScale, 1)
        ..setTranslationRaw(0, _currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var _currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var _currTrans = _height * (1 - _currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, _currScale, 1);
      matrix = Matrix4.diagonal3Values(1, _currScale, 1)
        ..setTranslationRaw(0, _currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var _currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var _currTrans = _height * (1 - _currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, _currScale, 1);
      matrix = Matrix4.diagonal3Values(1, _currScale, 1)
        ..setTranslationRaw(0, _currTrans, 0);
    } else {
      var _currScale = 0.8;
      var _currTrans = _height * (1 - _currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, _currScale, 1)
        ..setTranslationRaw(0, _currTrans, 0);
    }
    return GestureDetector(
      child: Transform(
        transform: matrix,
        child: Stack(
          children: [
            Container(
              height: Dimensions.height10 * 20,
              width: Dimensions.width10 * 200,
              margin: EdgeInsets.only(
                  top: Dimensions.height20,
                  left: Dimensions.height10,
                  right: Dimensions.height10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: Color.fromARGB(255, 87, 76, 148),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(services.imagePath),
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height30,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimensions.height20 * 7,
                width: Dimensions.width10 * 32,
                margin: EdgeInsets.only(
                    left: Dimensions.height10,
                    right: Dimensions.height10,
                    bottom: Dimensions.height20),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.01),
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Color.fromARGB(255, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 238, 236, 236),
                      blurRadius: Dimensions.radius5,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Color.fromARGB(255, 249, 248, 248),
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Color.fromARGB(255, 251, 250, 250),
                      offset: Offset(5, 0),
                    )
                  ],
                ),
                child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height15,
                        left: Dimensions.height15,
                        right: Dimensions.height15),
                    child: Column(
                      children: [
                        BigText(text: services.name),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Container(
                          height: Dimensions.height10 * 3,
                          child: SmallText(
                            text: services.description,
                            color: Colors.black,
                            size: Dimensions.font10,
                            textOverflow: TextOverflow.fade,
                          ),
                        ),
                        AppButton(btn_txt: "Book Now",buttonHeight: Dimensions.height50, buttonWidth: MediaQuery.of(context).size.width * 0.6)
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Get.toNamed(RouteHelper.getFoodDetail(index));
        AppConstant.toFood = true;
      },
    );
  }

  Widget _buildPopularRestaurant(int index, Restaurant restaurant) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(
            top: Dimensions.height5,
            bottom: Dimensions.height5,
            left: Dimensions.width10,
            right: Dimensions.width10),
        padding: EdgeInsets.only(
          left: Dimensions.width10,
          right: Dimensions.width10,
        ),
        height: Dimensions.height10 * 25,
        width: Dimensions.width20 * 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          color: Color.fromARGB(255, 255, 255, 255),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 238, 236, 236),
              blurRadius: Dimensions.radius5,
              offset: Offset(0, 5),
            ),
            BoxShadow(
              color: Color.fromARGB(255, 249, 248, 248),
              offset: Offset(-5, 0),
            ),
            BoxShadow(
              color: Color.fromARGB(255, 251, 250, 250),
              offset: Offset(5, 0),
            )
          ],
        ),
        child: Column(
          children: [
            Container(
              height: Dimensions.height10 * 15,
              width: Dimensions.width20 * 20,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(AppConstant.baseURL +
                        AppConstant.apiVersion +
                        restaurant.imagePath.toString()),
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.radius10)),
            ),
            Expanded(
              child: Container(
                width: Dimensions.width20 * 20,
                padding: EdgeInsets.only(
                    left: Dimensions.width10,
                    right: Dimensions.width10,
                    top: Dimensions.height10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: restaurant.name.toString(),
                      size: Dimensions.font10 * 1.5,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    SmallText(
                      text: restaurant.address.toString(),
                      color: Colors.black,
                      size: Dimensions.font10 * 1.3,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconAndTextWidget(
                              icon: Icons.star,
                              text: '4.0',
                              size: Dimensions.font10 * 1.3,
                              iconColor: AppColors.iconColor1,
                            ),
                            IconAndTextWidget(
                              icon: Icons.timer,
                              text: '15 mins',
                              size: Dimensions.font10 * 1.3,
                              iconColor: AppColors.mainColor,
                            ),
                            IconAndTextWidget(
                              icon: Icons.location_on,
                              text: '1.5 k.ms',
                              size: Dimensions.font10 * 1.3,
                              iconColor: AppColors.iconColor2,
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        // AppConstant.restaurantId = restaurant.id.toString();
        // Get.find<MenuByRestaurantController>().clear();
        // Get.find<MenuByRestaurantController>().categoryClear();
        // Get.find<MenuByRestaurantController>().get();
        // Get.toNamed(RouteHelper.getRestaurantMenu());
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Shimmer(
      gradient: const LinearGradient(
        colors: [
          Color(0xFFEBEBF4),
          Color(0xFFF4F4F4),
          Color(0xFFEBEBF4),
        ],
        stops: [
          0.1,
          0.3,
          0.4,
        ],
        begin: Alignment(-1.0, -0.3),
        end: Alignment(1.0, 0.3),
        tileMode: TileMode.clamp,
      ),
      child: Container(
        height: Dimensions.height10 * 62,
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 5, // You can adjust the number of shimmering cells
            itemBuilder: (_, __) => _buildSingleLoadingIndicator()),
      ),
    );
  }

  Widget _buildSingleLoadingIndicator() {
    return Shimmer(
      gradient: const LinearGradient(
        colors: [
          Color(0xFFEBEBF4),
          Color(0xFFF4F4F4),
          Color(0xFFEBEBF4),
        ],
        stops: [
          0.1,
          0.3,
          0.4,
        ],
        begin: Alignment(-1.0, -0.3),
        end: Alignment(1.0, 0.3),
        tileMode: TileMode.clamp,
      ),
      child: Container(
        height: Dimensions.height10 * 25,
        child: Container(
          padding: EdgeInsets.only(
              right: Dimensions.width10,
              left: Dimensions.width10,
              bottom: Dimensions.height20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Dimensions.height10 * 15,
                width: double.infinity,
                color: Colors.white,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Container(
                      width: double.infinity,
                      height: Dimensions.height10 * 2.4,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
