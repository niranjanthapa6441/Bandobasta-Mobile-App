import 'package:bandobasta/Pages/searchVenuePage/checkAvailabilityFormPage.dart';
import 'package:bandobasta/utils/color/colors.dart';
import 'package:bandobasta/utils/dimensions/dimension.dart';
import 'package:bandobasta/widgets/app_text_field.dart';
import 'package:bandobasta/widgets/big_text.dart';
import 'package:bandobasta/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchVenuePage extends StatefulWidget {
  @override
  _SearchVenuePageState createState() => _SearchVenuePageState();
}

class _SearchVenuePageState extends State<SearchVenuePage> {
  // Initial values for filters
  String selectedLocation = 'Kathmandu';
  double minPrice = 1000;
  double maxPrice = 10000;
  int selectedCapacity = 0;

  // Variables for Date and Time

  // Show the filter modal
 void _showFilterDialog() {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.85, // Adjust the modal height factor
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
                    isExpanded: true, // Makes dropdown take full width
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
                    divisions: 18, // Divides into steps of 500
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
                  SizedBox(height: 20), // Extra space to avoid bottom padding issue
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Dimensions.height20 * 3.5),
        child: AppBar(
          elevation: 0, // No shadow
          backgroundColor: Colors.white,
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
                hintStyle: TextStyle(color: Colors.grey), // Default hint text color
                prefixIcon: Icon(Icons.search, color: AppColors.themeColor), // Theme color for search icon
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: AppColors.themeColor), // Apply theme color to border
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: AppColors.themeColor, width: 2.0), // Darker border on focus
                ),
              ),
              style: TextStyle(color: Colors.black), // Search text color
            ),

            SizedBox(height: Dimensions.height20),

            // Venue cards section
            Expanded(
              child: ListView(
                children: [
                  VenueCard(
                    imageUrl: 'assets/images/venue.png',
                    name: 'Hotel Annapurna',
                    rating: 'Very Good',
                    reviews: 442,
                    location: 'Durbar Marg, Kathmandu, Nepal',
                    price: 'NPR 3500 onwards',
                    onCheckAvailability: () => _showAvailabilityDialog('Hotel Annapurna'),
                  ),
                  VenueCard(
                    imageUrl: 'assets/images/venue.png',
                    name: 'Classic Venue',
                    rating: 'Very Good',
                    reviews: 205,
                    location: 'Jamal, Lalitpur, Nepal',
                    price: 'NPR 1800 onwards',
                    onCheckAvailability: () => _showAvailabilityDialog('Classic Venue'),
                  ),
                  // Add more venue cards as needed
                ],
              ),
            ),
          ],
        ),
      ),
      // Floating Action Button for filter
      floatingActionButton: FloatingActionButton(
        onPressed: _showFilterDialog, // Opens the filter modal
        backgroundColor: AppColors.themeColor,
        child: Icon(
          FontAwesomeIcons.slidersH, // Filter icon
          color: Colors.white, // White icon for contrast
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Floating button position
    );
  }
}

// VenueCard Widget
class VenueCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String rating;
  final int reviews;
  final String location;
  final String price;
  final VoidCallback onCheckAvailability; // Callback for availability

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
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              height: 120, // Reduced height
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)), // Reduced font size
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    SizedBox(width: 4),
                    Text(rating, style: TextStyle(color: Colors.grey, fontSize: 12)), // Reduced font size
                    SizedBox(width: 4),
                    Text('($reviews reviews)', style: TextStyle(color: Colors.grey, fontSize: 12)), // Reduced font size
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
                    primary: AppColors.themeColor, // Theme color for button
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
