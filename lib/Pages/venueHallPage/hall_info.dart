import 'package:BandoBasta/Controller/venue_hall_controller.dart';
import 'package:BandoBasta/Pages/VenueInfoPage/photo_slider.dart';
import 'package:BandoBasta/Response/venue_hall_response.dart';
import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:BandoBasta/widgets/big_text.dart';
import 'package:BandoBasta/widgets/small_text.dart';
import 'package:get/get.dart';

class HallInfoPage extends StatefulWidget {
  final int pageId;
  final String venueName;
  final String imageURL;
  const HallInfoPage(
      {super.key,
      required this.pageId,
      required this.venueName,
      required this.imageURL});

  @override
  State<HallInfoPage> createState() => _HallInfoPageState();
}

class _HallInfoPageState extends State<HallInfoPage> {
  late int hallId;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    hallId = widget.pageId;
  }

  List<String> photoUrls = [];
  IconData getAmenityIcon(String amenityName) {
    switch (amenityName) {
      case 'Free Wi-Fi':
        return Icons.wifi;
      case 'Projector':
        return Icons.movie_creation;
      case 'Sound System':
        return Icons.audiotrack;
      case 'Catering Service':
        return Icons.fastfood;
      case 'Parking Space':
        return Icons.local_parking;
      case 'Lighting Equipment':
        return Icons.lightbulb;
      case 'Chairs & Tables':
        return Icons.event_seat;
      case 'Whiteboard':
        return Icons.menu_open;
      case 'Stage Setup':
        return Icons.stairs;
      case 'Photography':
        return Icons.photo_camera;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    int id = hallId;
    HallDetail hallDetail = Get.find<VenueHallController>().venueHalls[id];
    photoUrls = getHallImageURLs(hallDetail.hallImagePaths!);

    return Scaffold(
      appBar: AppBar(
        title: Text("Hall Info"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            clear();
          },
        ),
        actions: [
          if (AppConstant.isSelectHallPackageSelected)
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                // Navigate to the cart page or show a toast
                _showCartPage();
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
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
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
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
                  Icon(Icons.star, color: Colors.amber),
                  Icon(Icons.star, color: Colors.amber),
                  Icon(Icons.star, color: Colors.amber),
                  Icon(Icons.star, color: Colors.amber),
                  Icon(Icons.star, color: Colors.amber),
                  SizedBox(width: 8),
                  Text('5 reviews - '),
                  Text(
                    'Read all',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height10 * 1.6),
              // Location and Capacity
              Row(
                children: [
                  SizedBox(width: Dimensions.width10 * 0.6),
                  Icon(Icons.meeting_room, color: Colors.grey),
                  SizedBox(width: Dimensions.width10 * 0.4),
                  Text(
                    'Up to ' + hallDetail.capacity!.toString(),
                    style: TextStyle(fontSize: Dimensions.font10 * 1.4),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height10),
              if (AppConstant.isSelectHallPackageSelected)
                ElevatedButton(
                  onPressed: () {
                    _showAddToCartDialog(context, hallDetail);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.themeColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width20,
                      vertical: Dimensions.height10 * 1.6,
                    ),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Center(
                    child: BigText(
                      text: 'Select Hall',
                      color: Colors.white,
                    ),
                  ),
                ),
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
                ],
              ),
              SizedBox(height: Dimensions.height10),
              BigText(
                text: "Amenities",
                size: Dimensions.font20 - 2,
              ),
              SizedBox(height: Dimensions.height10),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddToCartDialog(BuildContext context, HallDetail hallDetail) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(Dimensions.radius20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(Dimensions.height20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BigText(
                text: hallDetail.name!,
                size: Dimensions.font10 * 2,
              ),
              SizedBox(height: Dimensions.height10),
              SmallText(
                text: 'Capacity: ${hallDetail.capacity!}',
                size: Dimensions.font10 * 1.6,
                color: Colors.black,
              ),
              SizedBox(height: Dimensions.height10),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(RouteHelper.getVenueMenus(
                      widget.venueName, widget.imageURL));
                  AppConstant.isHallBooking = true;
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.themeColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                    vertical: Dimensions.height10 * 1.6,
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Center(
                  child: BigText(
                    text: 'Add to cart',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCartPage() {
    // Implement the cart navigation or display logic here
  }

  Widget buildAmenity(String label, IconData icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: Dimensions.height20,
          child: Icon(
            icon,
            size: Dimensions.height10 * 2.4,
            color: Colors.teal,
          ),
        ),
        SizedBox(height: Dimensions.height10 * 0.8),
        Text(
          label,
          style: TextStyle(
              fontSize: Dimensions.font10 * 1.2, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
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
                      // Update the current index in the ValueNotifier
                      currentIndexNotifier.value = newIndex;
                    },
                  ),
                ),
                // Display the current index from the ValueNotifier
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

  List<String> getHallImageURLs(List<String> imageUrls) {
    return imageUrls.map((imageUrl) {
      return imageUrl;
    }).toList();
  }

  void clear() {
    Get.find<VenueHallController>().onClose();
    Get.find<VenueHallController>().get();
  }
}
