import 'package:BandoBasta/Controller/venue_package_controller.dart';
import 'package:BandoBasta/Pages/VenueInfoPage/photo_slider.dart';
import 'package:BandoBasta/Response/venu_package_response.dart';
import 'package:BandoBasta/Response/venue_menu_response.dart';
import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:BandoBasta/widgets/big_text.dart';
import 'package:get/get.dart';

class PackageInfoPage extends StatefulWidget {
  final int pageId;

  const PackageInfoPage({super.key, required this.pageId});

  @override
  State<PackageInfoPage> createState() => _PackageInfoPageState();
}

class _PackageInfoPageState extends State<PackageInfoPage> {
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
    Package package = Get.find<VenuePackageController>().venuePackages[id];
    photoUrls = getHallImageURLs(package.hallDetail!.hallImagePaths!);
    List<String> amenities = package.amenities!.take(10).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Package Info"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            clear();
          },
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
                      getHallImageURLs(package.hallDetail!.hallImagePaths!)
                          .first,
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
                      package.name!,
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
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Ensures the two sections are pushed to the ends
                children: [
                  // Price Section
                  Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.width10 *
                            0.5), // Adjust spacing on the left
                    child: Text(
                      'NPR ${package.price?.toStringAsFixed(2) ?? "0.00"}', // Format price with two decimal places
                      style: TextStyle(
                        fontSize: Dimensions.font10 *
                            1.5, // Slightly increase font size for emphasis
                        fontWeight:
                            FontWeight.bold, // Make the price bold for clarity
                      ),
                    ),
                  ),

                  // Capacity Section
                  Row(
                    children: [
                      Icon(
                        Icons.meeting_room,
                        color: Colors.grey
                            .shade600, // Use a softer grey tone for the icon
                        size: Dimensions.font10 *
                            1.5, // Match the icon size with text size
                      ),
                      SizedBox(
                          width: Dimensions.width10 *
                              0.5), // Space between icon and text
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Up to ',
                              style: TextStyle(
                                fontSize: Dimensions.font10 * 1.4,
                                color: Colors
                                    .black, // Ensure consistent text color
                              ),
                            ),
                            TextSpan(
                              text:
                                  '${package.hallDetail?.capacity?.toString() ?? "0"} people',
                              style: TextStyle(
                                fontSize: Dimensions.font10 * 1.4,
                                fontWeight: FontWeight
                                    .bold, // Highlight the capacity for visibility
                                color: Colors.black, // Consistent text color
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          width: Dimensions.width10 *
                              0.5), // Optional right padding for balance
                    ],
                  ),
                ],
              ),

              SizedBox(height: Dimensions.height10),
              ElevatedButton(
                onPressed: () {},
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
                    text: 'Select Package',
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
                    package.description!,
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
              SizedBox(height: Dimensions.height10 * 1.6),
              Text(
                'Package Menu',
                style: TextStyle(
                  fontSize: Dimensions.font10 * 1.8,
                  fontWeight: FontWeight.bold,
                ),
              ),
              buildMenuCard(package.menuDetail!),
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

  Widget buildMenuCard(MenuDetail menuDetail) {
    Map<String, int>? countsForCategory =
        countFoodItemsByCategoryMenu(menuDetail);

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
              ...countsForCategory.entries.map((entry) {
                return buildMenuRow(entry.key, entry.value);
              }).toList(),
              SizedBox(height: Dimensions.height10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(
                        RouteHelper.getMenuDetail(
                            menuDetail.menuType! + " Menu",
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
      return AppConstant.baseURL + AppConstant.apiVersion + imageUrl;
    }).toList();
  }

  Map<String, int> countFoodItemsByCategoryMenu(MenuDetail menuDetail) {
    Map<String, int> foodCategoryCounts = {};

    for (var food in menuDetail.foodDetails!) {
      if (foodCategoryCounts.containsKey(food.foodCategory)) {
        foodCategoryCounts[food.foodCategory!] =
            foodCategoryCounts[food.foodCategory]! + 1;
      } else {
        foodCategoryCounts[food.foodCategory!] = 1;
      }
    }
    return foodCategoryCounts;
  }

  void clear() {
    Get.find<VenuePackageController>().onClose();
    Get.find<VenuePackageController>().get();
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
