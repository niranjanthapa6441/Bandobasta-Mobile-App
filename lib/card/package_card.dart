import 'package:bandobasta/utils/color/colors.dart';
import 'package:bandobasta/utils/dimensions/dimension.dart';
import 'package:bandobasta/widgets/big_text.dart';
import 'package:flutter/material.dart';

class PackageCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String packageType;
  final String eventType;
  final double price;
  final String capacity;
  final String description;
  final VoidCallback onViewPackageInfo;

  PackageCard({
    required this.imageUrl,
    required this.name,
    required this.packageType,
    required this.eventType,
    required this.price,
    required this.capacity,
    required this.description,
    required this.onViewPackageInfo,
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
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: Dimensions.height10 * 12,
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
                BigText(
                  text: name,
                  size: Dimensions.font10 * 1.6,
                ),
                SizedBox(height: Dimensions.height10 * 0.4),
                Text(
                  'Up to ' + capacity + " people",
                  style: TextStyle(fontSize: Dimensions.font10 * 1.6),
                ),
                SizedBox(height: Dimensions.height10 * 0.4),
                Text('Price: ' + price.toString(),
                    style: TextStyle(
                        color: AppColors.themeColor,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: onViewPackageInfo,
                  child: BigText(
                    text: 'View Info',
                    color: Colors.white,
                    size: Dimensions.font10 * 1.4,
                  ),
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

  String getFloor(int floor) {
    String floorName;
    switch (floor) {
      case 0:
        floorName = "Ground Floor";
        break;
      case 1:
        floorName = "First Floor";
        break;
      case 2:
        floorName = "Second Floor";
        break;
      case 3:
        floorName = "Third Floor";
        break;
      case 4:
        floorName = "Fourth Floor";
        break;
      case 5:
        floorName = "Fifth Floor";
        break;
      default:
        floorName = "Sixth Floor";
        break;
    }
    return floorName;
  }
}
