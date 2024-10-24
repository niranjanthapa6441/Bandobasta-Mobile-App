import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:flutter/material.dart';

class VenueCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String rating;
  final String reviews;
  final String location;
  final String price;
  final VoidCallback onViewInfo;

  VenueCard({
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.reviews,
    required this.location,
    required this.price,
    required this.onViewInfo,
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
                Text(name,
                    style: TextStyle(
                        fontSize: Dimensions.font10 * 1.4,
                        fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Icon(Icons.star,
                        color: Colors.amber, size: Dimensions.height10),
                    SizedBox(width: Dimensions.width10 * 0.4),
                    Text(rating,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: Dimensions.font10 * 1.2)),
                    SizedBox(width: Dimensions.width10 * 0.4),
                    Text('($reviews reviews)',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: Dimensions.font10 * 1.2)),
                  ],
                ),
                SizedBox(height: Dimensions.height10 * 0.4),
                Text(location, style: TextStyle(color: Colors.grey)),
                SizedBox(height: Dimensions.height10 * 0.4),
                Text(price,
                    style: TextStyle(
                        color: AppColors.themeColor,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: Dimensions.height10 * 0.8),
                ElevatedButton(
                  onPressed: onViewInfo,
                  child: Text('View Info'),
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
}
