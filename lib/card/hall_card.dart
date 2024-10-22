import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:BandoBasta/widgets/big_text.dart';
import 'package:flutter/material.dart';

class HallCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int floorNumber;
  final String capacity;
  final String description;
  final VoidCallback onViewHallInfo;

  HallCard({
    required this.imageUrl,
    required this.name,
    required this.floorNumber,
    required this.capacity,
    required this.description,
    required this.onViewHallInfo,
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
                Text('Floor: ' + getFloor(floorNumber),
                    style: TextStyle(
                        color: AppColors.themeColor,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: onViewHallInfo,
                  child: BigText(
                    text: 'View Info',
                    color: Colors.white,
                    size: Dimensions.font10 * 1.4,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.themeColor,
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
