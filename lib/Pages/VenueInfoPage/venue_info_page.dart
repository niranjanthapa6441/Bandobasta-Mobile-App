import 'package:BandoBasta/Controller/venue_controller.dart';
import 'package:BandoBasta/Pages/VenueInfoPage/photo_slider.dart';
import 'package:BandoBasta/Pages/searchVenuePage/check_availability_form_page.dart';
import 'package:BandoBasta/Response/venue_response.dart';
import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:BandoBasta/widgets/big_text.dart';
import 'package:BandoBasta/widgets/small_text.dart';
import 'package:get/get.dart';

class VenueInfoPage extends StatefulWidget {
  final int pageId;

  const VenueInfoPage({super.key, required this.pageId});

  @override
  State<VenueInfoPage> createState() => _VenueInfoPageState();
}

class _VenueInfoPageState extends State<VenueInfoPage> {
  late int venueId;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    venueId = widget.pageId;
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
    int id = venueId;
    Venue venue = Get.find<VenueController>().venues[id];
    photoUrls = getVenueImageURLs(venue.venueImagePaths!);
    List<String> amenities = venue.amenities!.take(10).toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Dimensions.height20 * 3.5),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.themeColor,
            ),
            onPressed: () {
              Navigator.pop(context);
              clear();
            },
          ),
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Container(
                    height: Dimensions.height10 * 5,
                    width: Dimensions.height10 * 5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/wedding.png"),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.width5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: "BandoBasta",
                      color: AppColors.themeColor,
                      size: Dimensions.font20,
                      fontWeight: FontWeight.w900,
                    ),
                    SmallText(
                      text: "Effortless booking",
                      color: AppColors.themeColor,
                      size: Dimensions.font12,
                    ),
                  ],
                ),
              ],
            ),
          ),
          centerTitle: true,
        ),
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
                      getVenueImageURLs(venue.venueImagePaths!).first,
                      height: Dimensions.height10 * 20,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child; // Image loaded successfully
                        } else {
                          return Container(
                            height: Dimensions.height10 * 20,
                            width: double.infinity,
                            color: Colors.grey[
                                300], // Placeholder background color while loading
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
                      venue.name!,
                      style: TextStyle(
                        fontSize: Dimensions.font12 * 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            AppConstant.venueId = venue.id!;
                            Get.toNamed(RouteHelper.getVenueMenus(
                                venue.name!, photoUrls.first));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.restaurant_menu),
                              SizedBox(width: 8),
                              Text('Our Food Menu'),
                            ],
                          ),
                        ),
                        SizedBox(width: Dimensions.width10),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.card_giftcard),
                              SizedBox(width: 8),
                              Text('Create a Package'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            AppConstant.venueId = venue.id!;
                            Get.toNamed(RouteHelper.getVenueHalls(venue.name!,
                                getVenueImageURLs(venue.venueImagePaths!)[0]));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.meeting_room),
                              SizedBox(width: 8),
                              Text('View Halls'),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            AppConstant.venueId = venue.id!;
                            Get.toNamed(
                                RouteHelper.getVenuePackages(venue.name!));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.local_offer),
                              SizedBox(width: 8),
                              Text('View Packages'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height10 * 1.6),
              // Star Ratings and Reviews
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
                  Icon(Icons.location_on, color: Colors.grey),
                  SizedBox(width: Dimensions.width10 * 0.4),
                  Expanded(
                    child: Text(
                      venue.address!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: Dimensions.font10 * 1.4),
                    ),
                  ),
                  SizedBox(width: Dimensions.width10 * 0.6),
                  Icon(Icons.meeting_room, color: Colors.grey),
                  SizedBox(width: Dimensions.width10 * 0.4),
                  Text(
                    'Up to ' + venue.maxCapacity!,
                    style: TextStyle(fontSize: Dimensions.font10 * 1.4),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height10 * 1.6),
              ElevatedButton(
                onPressed: () {
                  if (AppConstant.isUserLoggedIn) {
                    AppConstant.venueId = venue.id!;
                    AppConstant.isSelectHallPackageSelected = true;
                    Get.toNamed(RouteHelper.getSelectHallPackagePage(
                        venue.name!,
                        getVenueImageURLs(venue.venueImagePaths!)[0]));
                  } else {
                    clear();
                    Get.toNamed(RouteHelper.getSignIn());
                  }
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
                    text: 'Book Now',
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
                    venue.description!,
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
              Container(
                height: Dimensions.height20 * 10,
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 5,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: Dimensions.height20,
                  crossAxisSpacing: Dimensions.width20,
                  children: amenities.map((amenity) {
                    return buildAmenity(amenity, getAmenityIcon(amenity));
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAvailabilityDialog(String venueName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width:
                MediaQuery.of(context).size.width * 0.8, // 80% of screen width
            height: MediaQuery.of(context).size.height *
                0.7, // 50% of screen height
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BigText(text: venueName),
                SizedBox(height: 20),
                Expanded(
                    child: CheckAvailabilityPage()), // To fill the content area
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: SmallText(
                        text: 'Cancel',
                        color: AppColors.themeColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
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
            height: MediaQuery.of(context).size.height *
                0.6, // Set height of dialog
            width:
                MediaQuery.of(context).size.width * 0.8, // Set width of dialog
            padding: EdgeInsets.all(10),
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
                          _showPhotoDetailDialog(
                              context, index); // Show the selected photo
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
                                color: Colors
                                    .grey, // Placeholder when image fails to load
                                child: Icon(
                                  Icons
                                      .broken_image, // Placeholder icon for broken image
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

  List<String> getVenueImageURLs(List<String> imageUrls) {
    return imageUrls.map((imageUrl) {
      return AppConstant.baseURL + AppConstant.apiVersion + imageUrl;
    }).toList();
  }

  void clear() {
    AppConstant.venueName = '';
    AppConstant.venueImageURL = '';
    Get.find<VenueController>().onClose();
    Get.find<VenueController>().get();
  }
}
