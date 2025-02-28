import 'package:BandoBasta/Controller/booking_controller.dart';
import 'package:BandoBasta/Pages/VenueInfoPage/photo_slider.dart';
import 'package:BandoBasta/Response/hall_booking_response.dart';
import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:BandoBasta/widgets/big_text.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingInfoPage extends StatefulWidget {
  final int pageId;

  const BookingInfoPage({super.key, required this.pageId});

  @override
  State<BookingInfoPage> createState() => _BookingInfoPageState();
}

class _BookingInfoPageState extends State<BookingInfoPage> {
  late int bookingId;
  bool _isExpanded = false;
  List<String> photoUrls = [];

  @override
  void initState() {
    super.initState();
    bookingId = widget.pageId;
  }

  @override
  Widget build(BuildContext context) {
    Booking booking = Get.find<BookingController>().bookings[bookingId];

    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Info'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
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
                        _buildBookingDetail(booking),
                        _buildMenuCard(booking.menuDetail!),
                        _buildHallCard(
                            booking.hallDetail!, AppConstant.hallIndex),
                      ],
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

  Widget _buildBookingDetail(Booking booking) {
    return Card(
      key: Key('bookingDetailCard'),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(Dimensions.height10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigText(
              text: 'Booking Details:',
              size: Dimensions.font10 * 1.6,
            ),
            SizedBox(height: Dimensions.height10 * 1.6),
            BigText(
              text: 'Number Of Guests: ${booking.numberOfGuests}',
              size: Dimensions.font10 * 1.4,
            ),
            SizedBox(height: Dimensions.height10 * 1.6),
            BigText(
              text: 'Menu Price: ${booking.menuDetail!.price!}',
              size: Dimensions.font10 * 1.4,
            ),
            SizedBox(height: Dimensions.height10 * 1.6),
            BigText(
              text: 'Estimated Booking Price: NPR ${booking.price}',
              size: Dimensions.font10 * 1.4,
            ),
            SizedBox(height: Dimensions.height10 * 1.6),
            Row(
              children: [
                BigText(
                  text: 'Booked Date: ${booking.bookedForDate}',
                  size: Dimensions.font10 * 1.4,
                ),
                SizedBox(width: Dimensions.width10 * 0.8),
                BigText(
                  text:
                      'Time: ${_formatTime(booking.startTime)} - ${_formatTime(booking.endTime)}',
                  color: AppColors.themeColor,
                  size: Dimensions.font10 * 1.4,
                ),
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
              color: Colors.black, // Main title color
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
                  width: double
                      .infinity, 
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(
                        RouteHelper.getBookingMenu(
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
        Text(
            label), // Assuming the `value` function is replaced with just label
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
              color: Colors.black, // Main title color
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
                // Display Capacity
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
                // Display Description
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
                // View Photos Button (inside the ExpansionTile)
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

  String _formatTime(String? time) {
    if (time == null || time.isEmpty) return '';

    try {
      DateTime parsedTime =
          DateTime.parse('1970-01-01T$time'); // Add a date prefix for parsing.
      return "${parsedTime.hour}:${parsedTime.minute.toString().padLeft(2, '0')}"; // Format as "HH:mm".
    } catch (e) {
      return time; // Fallback to the original string if parsing fails.
    }
  }
}
