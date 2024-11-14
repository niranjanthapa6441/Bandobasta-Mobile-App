import 'package:BandoBasta/Controller/booking_controller.dart';
import 'package:BandoBasta/Controller/venue_controller.dart';
import 'package:BandoBasta/Pages/VenueInfoPage/photo_slider.dart';
import 'package:BandoBasta/Request/hall_booking_request.dart';
import 'package:BandoBasta/Response/venue_menu_response.dart';
import 'package:BandoBasta/Response/venue_hall_response.dart';
import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:BandoBasta/utils/auth_service/auth_service.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:BandoBasta/widgets/big_text.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPagePageState();
}

class _CheckoutPagePageState extends State<CheckoutPage> {
  bool _isLoading = false;
  bool _isExpanded = false;
  List<String> photoUrls = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            AppConstant.isSelectHallPackageSelected = true;
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(Dimensions.height10 * 0.5),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildHallCard(
                            AppConstant.hallDetail, AppConstant.hallIndex),
                        _buildMenuCard(AppConstant.menuDetail),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height20),
                ElevatedButton(
                  onPressed: () {
                    _makeBooking();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.themeColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width20,
                      vertical: Dimensions.height10 * 1.6,
                    ),
                  ),
                  child: Container(
                    width: Dimensions.width10 * 20,
                    child: Center(
                      child: BigText(
                        text: 'Checkout',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black
                  .withOpacity(0.5), // Optional overlay background color
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.themeColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(MenuDetail menuDetail) {
    Map<String, Map<String, Map<String, dynamic>>> categorizedMenu =
        getCategorizedMenu(menuDetail);

    return Padding(
      padding: EdgeInsets.all(Dimensions.height10 * 0.8),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(Dimensions.height10 * 1.6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${menuDetail.menuType} Menu',
                  style: TextStyle(
                      fontSize: Dimensions.font10 * 1.8,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: Dimensions.height10 * 0.5),
              Text(menuDetail.price!.toString(),
                  style: TextStyle(
                      fontSize: Dimensions.font10 * 1.6,
                      color: AppColors.themeColor)),
              SizedBox(height: Dimensions.height10),
              ...categorizedMenu.entries.map((categoryEntry) {
                String category = categoryEntry.key;
                Map<String, Map<String, dynamic>> subCategories =
                    categoryEntry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(category,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    ...subCategories.entries.map((subCategoryEntry) {
                      String subCategory = subCategoryEntry.key;
                      int maxSelection = subCategoryEntry.value['maxSelection'];
                      List foods = subCategoryEntry.value['foods'];

                      return buildMenuRow(subCategory, maxSelection);
                    }).toList(),
                  ],
                );
              }).toList(),
              SizedBox(height: Dimensions.height10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
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
        Text(
            label), // Assuming the `value` function is replaced with just label
        Text(count.toString()),
      ],
    );
  }

  Widget _buildHallCard(HallDetail hallDetail, int index) {
    photoUrls = getHallImageURLs(hallDetail.hallImagePaths!);

    return Padding(
      padding: EdgeInsets.all(Dimensions.height10 * 1.6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  getHallImageURLs(hallDetail.hallImagePaths!).first,
                  height: Dimensions.height10 * 20,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Container(
                        height: Dimensions.height10 * 20,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        ),
                      );
                    }
                  },
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Container(
                      height: Dimensions.height10 * 20,
                      width: double.infinity,
                      color: Colors.grey,
                      child: Icon(
                        Icons.broken_image,
                        size: Dimensions.height10 * 5,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                right: Dimensions.width10,
                bottom: Dimensions.height10,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _showPhotoGalleryDialog(context);
                  },
                  icon: Icon(Icons.photo_library),
                  label: Text("View all photos"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black54,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: Dimensions.height10),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hallDetail.name!,
                  style: TextStyle(
                    fontSize: Dimensions.font12 * 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.height10 * 1.6),
          Row(
            children: [
              BigText(
                text: 'Booked Date: ${AppConstant.selectedDate}',
                size: Dimensions.font10 * 1.4,
              ),
              SizedBox(width: Dimensions.width10 * 0.8),
              BigText(
                text: 'Time: ${AppConstant.selectedTime}',
                color: AppColors.themeColor,
                size: Dimensions.font10 * 1.4,
              )
            ],
          ),
          SizedBox(height: Dimensions.height10 * 1.6),
          // Location and Capacity
          Row(
            children: [
              SizedBox(width: Dimensions.width10 * 0.6),
              Icon(Icons.people, color: Colors.grey),
              SizedBox(width: Dimensions.width10 * 0.4),
              Text(
                'Up to ${hallDetail.capacity!} people',
                style: TextStyle(fontSize: Dimensions.font10 * 1.4),
              ),
            ],
          ),
          SizedBox(height: Dimensions.height10),
          SizedBox(height: Dimensions.height10 * 1.6),
          Text(
            'About this space',
            style: TextStyle(
              fontSize: Dimensions.font10 * 1.8,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Dimensions.height10 * 0.8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hallDetail.description!,
                style: TextStyle(fontSize: Dimensions.font10 * 1.6),
                maxLines: _isExpanded ? null : 3,
                overflow:
                    _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(
                  _isExpanded ? 'Show Less' : 'Show More',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String? getImagePath(List<String>? hallImagePaths) {
    if (hallImagePaths != null && hallImagePaths.isNotEmpty) {
      return hallImagePaths[0];
    }
    return null;
  }

  List<String> getHallImageURLs(List<String> imageUrls) {
    return imageUrls.map((imageUrl) {
      return AppConstant.baseURL + AppConstant.apiVersion + imageUrl;
    }).toList();
  }

  void _showPhotoGalleryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                Text(
                  'Photo Gallery',
                  style: TextStyle(
                    fontSize: Dimensions.font10 * 2.4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: photoUrls.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _showPhotoDetailDialog(context, index);
                        },
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius10 * 0.8),
                          child: Image.network(
                            photoUrls[index],
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child; // Image loaded successfully
                              } else {
                                return Container(
                                  color: Colors.grey[
                                      300], // Placeholder background while loading
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                    ),
                                  ),
                                );
                              }
                            },
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              return Container(
                                color: Colors.grey,
                                child: Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPhotoDetailDialog(BuildContext context, int initialIndex) {
    ValueNotifier<int> currentIndexNotifier = ValueNotifier<int>(initialIndex);
    PageController _pageController = PageController(initialPage: initialIndex);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: photoUrls.length,
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10 * 0.8),
                        child: Image.network(
                          photoUrls[index],
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child; // Image loaded successfully
                            } else {
                              return Container(
                                color: Colors
                                    .grey[300], // Placeholder while loading
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null,
                                  ),
                                ),
                              );
                            }
                          },
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return Container(
                              color: Colors
                                  .grey, // Fallback when image fails to load
                              child: Icon(
                                Icons.broken_image,
                                size: 50,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      );
                    },
                    onPageChanged: (newIndex) {
                      currentIndexNotifier.value = newIndex;
                    },
                  ),
                ),
                ValueListenableBuilder<int>(
                  valueListenable: currentIndexNotifier,
                  builder: (context, currentIndex, _) {
                    return SlideIndicator(
                      currentIndex: currentIndex,
                      totalImages: photoUrls.length,
                    );
                  },
                ),
                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _makeBooking() async {
    setState(() {
      _isLoading = true;
    });
    final AuthService _authservice = AuthService();
    String? userId = await _authservice.getUserId();
    String menuId = AppConstant.menuDetail.id!;
    List<String> foodIds = AppConstant.menuDetail.foodDetails
            ?.map((food) => food.id ?? '')
            .toList() ??
        [];
    String hallAvailabilityId = AppConstant.hallAvailabilityId;

    String eventType = AppConstant.eventType;

    HallBookingRequest hallBookingRequest = HallBookingRequest(
        userId: userId,
        menuId: menuId,
        id: hallAvailabilityId,
        eventType: eventType,
        numberOfGuests: AppConstant.numberOfGuests,
        foodIds: foodIds);
    var bookingController = Get.find<BookingController>();
    bookingController.saveHallBooking(hallBookingRequest).then((status) {
      if (status.isSuccess) {
        setState(() {
          _isLoading = false;
        });
        AppConstant.address = "";
        AppConstant.maxCapacity = 0;
        AppConstant.minCapacity = 0;
        AppConstant.minPrice = 0;
        AppConstant.maxPrice = 0;
        AppConstant.venueName = "";
        AppConstant.isSelectHallPackageSelected = false;
        Get.find<VenueController>().onClose();
        Get.find<VenueController>().get();
        Get.toNamed(RouteHelper.getNavigation());
        showCustomSnackBar("Booking Successful!!",
            title: "Booking", color: Colors.green);
      } else {
        setState(() {
          _isLoading = false;
        });
        showCustomSnackBar(status.message,
            title: "Booking Failed !!", color: Colors.red);
      }
    });
  }

  void showCustomSnackBar(String message,
      {required String title, MaterialColor? color}) {
    Get.snackbar(title, message,
        titleText: BigText(
          text: title,
          color: Colors.white,
        ),
        messageText: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: color);
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
