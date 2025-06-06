import 'package:BandoBasta/Controller/venue_controller.dart';
import 'package:BandoBasta/Pages/VenueInfoPage/photo_slider.dart';
import 'package:BandoBasta/Response/venue_response.dart';
import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:BandoBasta/utils/auth_service/auth_service.dart';
import 'package:BandoBasta/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:BandoBasta/widgets/big_text.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VenueInfoPage extends StatefulWidget {
  final int pageId;

  const VenueInfoPage({super.key, required this.pageId});

  @override
  State<VenueInfoPage> createState() => _VenueInfoPageState();
}

class _VenueInfoPageState extends State<VenueInfoPage> {
  late int venueId;
  late Venue venue;

  bool _isExpanded = false;
  final AuthService _authService = AuthService();
  bool isTokenExpired = false;
  final _dateController = TextEditingController();
  final _numberOfGuestsController = TextEditingController();
  int? guests;
  bool _isDateSelected = false;
  DateTime _date = DateTime.now();
  String? _selectedEventType; // Add variable for selected event type

  final List<String> eventTypes = [
    'Wedding',
    'Birthday',
    'Corporate Event',
    'Party',
    'Rice Feeding Ceremenoy',
    'Bratabanda',
    'Other'
  ];
  @override
  void initState() {
    super.initState();
    checkTokenValidation();
    venueId = widget.pageId;
  }

  List<String> photoUrls = [];
  IconData getAmenityIcon(String amenityName) {
    switch (amenityName) {
      case 'Luxury Event Venues':
        return Icons.event;
      case 'Spa & Wellness Center':
        return Icons.spa;
      case 'Gourmet Dining':
        return Icons.restaurant;
      case 'Concierge Services':
        return Icons.support_agent;
      case 'Valet Parking':
        return Icons.local_parking;
      case 'Private Poolside Cabanas':
        return Icons.pool;
      case 'Fitness Center':
        return Icons.fitness_center;
      case 'High-Speed Wi-Fi':
        return Icons.wifi;
      case 'Butler Service':
        return Icons.room_service;
      case 'Helipad':
        return Icons.flight;
      case 'Business Center':
        return Icons.business_center;
      case 'Bar & Lounge':
        return Icons.local_bar;
      case 'Airport Shuttle':
        return Icons.airport_shuttle;
      case 'Rooftop Terrace':
        return Icons.view_day;
      case 'In-Room Safe':
        return Icons.lock;
      case 'Luxury Suites':
        return Icons.hotel;
      case 'Conference Room':
        return Icons.meeting_room;
      case 'Banquet Hall':
        return Icons.hail_outlined;
      case 'Free Wi-Fi':
        return Icons.wifi; // Represents Wi-Fi
      case 'Projector':
        return Icons.movie_creation; // Represents projector
      case 'Sound System':
        return Icons.audiotrack; // Represents sound system
      case 'Catering Service':
        return Icons.fastfood; // Represents food services
      case 'Parking Space':
        return Icons.local_parking; // Represents parking space
      case 'Lighting Equipment':
        return Icons.lightbulb; // Represents lighting equipment
      case 'Chairs & Tables':
        return Icons.event_seat; // Represents chairs
      case 'Whiteboard':
        return Icons.menu_open; // Represents a whiteboard
      case 'Stage Setup':
        return Icons.stairs; // Represents stage setup
      case 'Photography':
        return Icons.photo_camera;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    int id = venueId;
    List<String> amenities;
    if (!AppConstant.isFeaturedVenueSelected) {
      venue = Get.find<VenueController>().availableVenuesForSelectedDate[id];
      photoUrls = venue.venueImagePaths!;
      amenities = venue.amenities!.take(10).toList();
    } else {
      venue = Get.find<VenueController>().venues[id];
      photoUrls = venue.venueImagePaths!;
      amenities = venue.amenities!.take(10).toList();
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Dimensions.height10 * 8,
        automaticallyImplyLeading: false,
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
        elevation: 0, // No shadow
        backgroundColor: Colors.white,
        title: Center(
          child: Container(
            height: Dimensions.height10 * 9,
            width: Dimensions.height10 * 20, // Adjust the width if needed
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain, // Use contain to fit the whole image
                image: AssetImage("assets/images/logo.png"), // Your logo image
              ),
            ),
          ),
        ),
        centerTitle: true,
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
                      venue.venueImagePaths!.first,
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
                            Get.toNamed(RouteHelper.getVenueHalls(
                                venue.name!, venue.venueImagePaths![0]));
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
                            Get.toNamed(RouteHelper.getVenuePackages(
                                venue.name!, venue.venueImagePaths![0]));
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
                  if (!isTokenExpired) {
                    if (AppConstant.isFeaturedVenueSelected) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Check Availability"),
                            content: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: _buildCheckAvailability(),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancel"),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      AppConstant.venueId = venue.id!;
                      AppConstant.isSelectHallPackageSelected = true;
                      Get.toNamed(RouteHelper.getSelectHallPackagePage(
                          venue.name!, venue.venueImagePaths![0]));
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Sign In Required"),
                          content: Text(
                              "You need to sign in before booking. Would you like to sign in now?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                                Get.toNamed(RouteHelper.getSignIn());
                              },
                              child: Text("Sign In"),
                            ),
                          ],
                        );
                      },
                    );
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

  void clear() {
    AppConstant.venueName = '';
    AppConstant.venueImageURL = '';
    Get.find<VenueController>().onClose();
    Get.find<VenueController>().get();
    Get.find<VenueController>().getAvailableVenues();
  }

  void checkTokenValidation() async {
    bool expired = await _authService.isTokenExpired();
    setState(() {
      isTokenExpired = expired;
    });
  }

  Widget _buildCheckAvailability() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      padding: EdgeInsets.all(Dimensions.height10 * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Dimensions.height10 * 6,
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelStyle: TextStyle(color: AppColors.mainBlackColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                  borderSide: BorderSide(color: AppColors.mainBlackColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                  borderSide:
                      BorderSide(color: AppColors.mainBlackColor, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                  borderSide:
                      BorderSide(color: AppColors.mainBlackColor, width: 1.5),
                ),
              ),
              hint: Text('Select Event Type'),
              items:
                  eventTypes.map<DropdownMenuItem<String>>((String eventType) {
                return DropdownMenuItem<String>(
                  value: eventType,
                  child: Text(eventType),
                );
              }).toList(),
              value: _selectedEventType,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedEventType = newValue;
                });
              },
            ),
          ),
          SizedBox(height: Dimensions.height15),
          AppTextField(
            textEditingController: _dateController,
            hintText: _isDateSelected
                ? DateFormat.yMMMMd().format(_date)
                : "Select Check-In Date",
            icon: Icons.calendar_today_outlined,
            readOnly: true,
            width: double.infinity,
            widget: IconButton(
              onPressed: () => _getDate(),
              icon: Icon(
                Icons.calendar_today_outlined,
                color: AppColors.mainBlackColor,
              ),
            ),
          ),
          SizedBox(height: Dimensions.height15),
          AppTextField(
            textEditingController: _numberOfGuestsController,
            hintText: "Number of Guests",
            width: Dimensions.width10 * 14,
            icon: Icons.people,
            readOnly: false,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          SizedBox(height: Dimensions.height15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_isValidInput()) {
                  AppConstant.eventType =
                      _transformEventType(_selectedEventType!);
                  AppConstant.selectedDate =
                      DateFormat('yyyy-MM-dd').format(_date);
                  AppConstant.numberOfGuests =
                      int.parse(_numberOfGuestsController.text);
                  AppConstant.isFeaturedVenueSelected = false;
                  AppConstant.venueId = venue.id!;
                  AppConstant.isSelectHallPackageSelected = true;
                  Navigator.pop(context);
                  Get.toNamed(RouteHelper.getSelectHallPackagePage(
                      venue.name!, venue.venueImagePaths![0]));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            "Please select an event type, valid date, and number of guests")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.themeColor,
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.height10 * 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                ),
              ),
              child: BigText(
                text: 'Check Availability',
                color: Colors.white,
                size: Dimensions.font10 * 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isValidInput() {
    return _selectedEventType != null &&
        _isDateSelected &&
        _numberOfGuestsController.text.isNotEmpty &&
        int.tryParse(_numberOfGuestsController.text) != null &&
        int.parse(_numberOfGuestsController.text) > 0;
  }

  _getDate() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // Prevent selecting past dates
      lastDate: DateTime(9999),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: AppColors.themeColor, // Change the primary color here
            ),
          ),
          child: child!,
        );
      },
    );
    if (_pickerDate != null) {
      setState(() {
        _isDateSelected = true;
        _date = _pickerDate;
        _dateController.text = DateFormat.yMMMMd().format(_pickerDate);
      });
    }
  }

  String _transformEventType(String? eventType) {
    switch (eventType) {
      case "Wedding":
        return "WEDDING";
      case "Conference Event":
        return "CONFERENCE_EVENT";
      case "Birthday Party":
        return "BIRTHDAY_PARTY";
      case "Corporate Meeting":
        return "CORPORATE_MEETING";
      case "Bratabanda":
        return "BRATABANDA";
      case "Rice Feeding Ceremony":
        return "RICE_FEEDING_CEREMONY";
      default:
        return eventType!.toUpperCase().replaceAll(' ', '_');
    }
  }
}
