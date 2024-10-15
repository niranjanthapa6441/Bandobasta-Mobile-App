import 'package:bandobasta/Controller/venueController.dart';
import 'package:bandobasta/Pages/searchVenuePage/checkAvailabilityFormPage.dart';
import 'package:bandobasta/Response/venueResponse.dart';
import 'package:bandobasta/utils/app_constants/app_constant.dart';
import 'package:bandobasta/utils/color/colors.dart';
import 'package:bandobasta/utils/dimensions/dimension.dart';
import 'package:bandobasta/widgets/big_text.dart';
import 'package:bandobasta/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SearchVenuePage extends StatefulWidget {
  @override
  _SearchVenuePageState createState() => _SearchVenuePageState();
}

class _SearchVenuePageState extends State<SearchVenuePage> {
  // Controller instance

  // Initial values for filters
  String selectedLocation = 'Kathmandu';
  double minPrice = 1000;
  double maxPrice = 10000;
  int selectedCapacity = 0;

  // Show the filter modal
  void _showFilterDialog() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.85,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Filter', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    // Location filter
                    Text('Location'),
                    DropdownButton<String>(
                      value: selectedLocation,
                      isExpanded: true,
                      items: ['Kathmandu', 'Pokhara', 'Bhaktapur'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedLocation = value!;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    // Price range filter
                    Text('Price Range'),
                    RangeSlider(
                      values: RangeValues(minPrice, maxPrice),
                      min: 1000,
                      max: 10000,
                      divisions: 18,
                      onChanged: (RangeValues values) {
                        setState(() {
                          minPrice = values.start;
                          maxPrice = values.end;
                        });
                      },
                    ),
                    Text("Min: ${minPrice.toInt()} NPR - Max: ${maxPrice.toInt()} NPR"),
                    SizedBox(height: 20),
                    // Capacity filter
                    Text('Capacity'),
                    Column(
                      children: <Widget>[
                        RadioListTile(
                          title: const Text('Up to 100'),
                          value: 0,
                          groupValue: selectedCapacity,
                          onChanged: (int? value) {
                            setState(() {
                              selectedCapacity = value!;
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text('100-300'),
                          value: 1,
                          groupValue: selectedCapacity,
                          onChanged: (int? value) {
                            setState(() {
                              selectedCapacity = value!;
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text('300-500'),
                          value: 2,
                          groupValue: selectedCapacity,
                          onChanged: (int? value) {
                            setState(() {
                              selectedCapacity = value!;
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text('500+'),
                          value: 3,
                          groupValue: selectedCapacity,
                          onChanged: (int? value) {
                            setState(() {
                              selectedCapacity = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      child: Text('Apply'),
                      onPressed: () {
                        // Print all selected filters
                        print("Selected Location: $selectedLocation");
                        print("Price Range: ${minPrice.toInt()} NPR - ${maxPrice.toInt()} NPR");
                        print("Selected Capacity: $selectedCapacity");

                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showAvailabilityDialog(String venueName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Check Availability for $venueName'),
          content: CheckAvailabilityPage(),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      text: "BANDOBASTA",
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: AppColors.themeColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: AppColors.themeColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: AppColors.themeColor, width: 2.0),
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: Dimensions.height20),
            // Venue cards section
            Expanded(
              child: GetBuilder<VenueController>(
                builder: (controller) {
                  return ListView.builder(
                    itemCount: controller.venues.length,
                    itemBuilder: (context, index) {
                      Venue venue = controller.venues[index];
                      return VenueCard(
                        imageUrl: AppConstant.baseURL + AppConstant.apiVersion + getImagePath(venue.venueImagePaths)!,
                        name: venue.name!,
                        rating: "4.0",
                        reviews: "Very good",
                        location: venue.address!,
                        price: "Starting from: NPR " + venue.startingPrice!,
                        onCheckAvailability: () => _showAvailabilityDialog(venue.name!),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Floating Action Button for filter
      floatingActionButton: FloatingActionButton(
        onPressed: _showFilterDialog,
        backgroundColor: AppColors.themeColor,
        child: Icon(
          FontAwesomeIcons.slidersH,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
  
  String? getImagePath(List<String>? venueImagePaths) {
    if (venueImagePaths != null && venueImagePaths!.isNotEmpty) {
      return venueImagePaths![0]; // Return the first image path
    }
    return null; // Return null if no images are available
  }
}

// VenueCard Widget
class VenueCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String rating;
  final String reviews;
  final String location;
  final String price;
  final VoidCallback onCheckAvailability;

  VenueCard({
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.reviews,
    required this.location,
    required this.price,
    required this.onCheckAvailability,
  });

  @override
Widget build(BuildContext context) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    elevation: 4,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
          child: Image.network( // Use Image.network instead of NetworkImage
            imageUrl,
            fit: BoxFit.cover,
            height: 120,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: Dimensions.height10 * 12,
                width: double.infinity,
                color: Colors.grey, // Placeholder color for loading
                child: Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  SizedBox(width: 4),
                  Text(rating, style: TextStyle(color: Colors.grey, fontSize: 12)),
                  SizedBox(width: 4),
                  Text('($reviews reviews)', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
              SizedBox(height: 4),
              Text(location, style: TextStyle(color: Colors.grey)),
              SizedBox(height: 4),
              Text(price, style: TextStyle(color: AppColors.themeColor, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: onCheckAvailability,
                child: Text('Check Availability'),
                style: ElevatedButton.styleFrom(
                  primary: AppColors.themeColor,
                  textStyle: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

}
