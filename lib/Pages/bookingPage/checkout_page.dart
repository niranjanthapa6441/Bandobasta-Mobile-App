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
                        _buildBookingDetail(),
                        _buildMenuCard(AppConstant.menuDetail),
                        _buildHallCard(
                            AppConstant.hallDetail, AppConstant.hallIndex),
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

  Widget _buildBookingDetail() {
    return Card(
      key: Key('bookingDetailCard'),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10), // Optional: to round the corners
      ),
      child: Padding(
        padding:
            EdgeInsets.all(Dimensions.height10), // Padding around the content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigText(
              text: 'Booking Details:',
              size: Dimensions.font10 * 1.6,
            ),
            SizedBox(height: Dimensions.height10 * 1.6),
            BigText(
              text: 'Number Of Guests: ${AppConstant.numberOfGuests}',
              size: Dimensions.font10 * 1.4,
            ),
            SizedBox(height: Dimensions.height10 * 1.6),
            BigText(
              text: 'Menu Price: ${AppConstant.menuDetail.price}',
              size: Dimensions.font10 * 1.4,
            ),
            SizedBox(height: Dimensions.height10 * 1.6),
            BigText(
              text:
                  'Estimated Price: NPR ${AppConstant.numberOfGuests * AppConstant.menuDetail.price!}',
              size: Dimensions.font10 * 1.4,
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
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(MenuDetail menuDetail) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius15),
      ),
      child: ExpansionTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigText(
              text: 'View Your Menu',
              color: Colors.black,
              size: Dimensions.font20,
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_drop_down, color: AppColors.themeColor),
        children: [
          Padding(
            padding: EdgeInsets.all(Dimensions.height10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(
                  text: 'Menu Type: ${menuDetail.menuType}',
                  size: Dimensions.font10 * 1.6,
                  color: Colors.black,
                ),
                SizedBox(height: Dimensions.height10),
                BigText(
                  text: 'Price: NPR ${menuDetail.price}',
                  size: Dimensions.font10 * 1.6,
                  color: Colors.black,
                ),
                SizedBox(height: Dimensions.height20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(
                        RouteHelper.getMenuDetail(
                          "${menuDetail.menuType} Menu",
                          menuDetail.price.toString(),
                        ),
                        arguments: menuDetail,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.themeColor,
                      padding: EdgeInsets.symmetric(
                        vertical: Dimensions.height20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                      ),
                    ),
                    child: BigText(
                      text: 'View Full Menu Details',
                      color: Colors.white,
                      size: Dimensions.font10 * 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuRow(String label, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(count.toString()),
      ],
    );
  }

  Widget _buildHallCard(HallDetail hallDetail, int index) {
    photoUrls = getHallImageURLs(hallDetail.hallImagePaths!);
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius15),
      ),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BigText(
              text: "View your Hall Detail",
              color: Colors.black,
              size: Dimensions.font20,
            ),
            Icon(Icons.arrow_drop_down, color: AppColors.themeColor),
          ],
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(Dimensions.height10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(height: Dimensions.height10),
                Row(
                  children: [
                    Icon(Icons.people, color: Colors.grey),
                    SizedBox(width: Dimensions.width10 * 0.4),
                    Text(
                      'Up to ${hallDetail.capacity!} people',
                      style: TextStyle(fontSize: Dimensions.font10 * 1.4),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.height10),
                Text(
                  'About this space',
                  style: TextStyle(
                    fontSize: Dimensions.font10 * 1.8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Dimensions.height10 * 0.8),
                Text(
                  hallDetail.description!,
                  style: TextStyle(fontSize: Dimensions.font10 * 1.6),
                  maxLines: _isExpanded ? null : 3,
                  overflow: _isExpanded
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
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
                SizedBox(height: Dimensions.height10),
                ElevatedButton.icon(
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
              ],
            ),
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
      return imageUrl;
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
                                return child;
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
    final bool confirmed = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirm Booking"),
              content: const Text(
                  "Are you sure you want to proceed with the booking?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // User cancels the action
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text("Confirm"),
                ),
              ],
            );
          },
        ) ??
        false;

    if (!confirmed) {
      return;
    }

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
      foodIds: foodIds,
    );
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
