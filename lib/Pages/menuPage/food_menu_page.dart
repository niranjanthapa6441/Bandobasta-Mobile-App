import 'package:bandobasta/Controller/venueMenuController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodMenuScreen extends StatelessWidget {
  final String targetMenuId;
  final String menuName;
  final String price;

  FoodMenuScreen(
      {super.key,
      required this.targetMenuId,
      required this.menuName,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(menuName),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<VenueMenuController>(
          builder: (controller) {
            if (!controller.isLoaded) {
              return Center(child: CircularProgressIndicator());
            }

            List<Map<String, dynamic>> categorizedMenu =
                controller.getCategorizedMenu(controller.venueMenus);

            final menu = categorizedMenu.firstWhere(
              (m) => m['menuId'] == targetMenuId,
              orElse: () => {},
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Fixed Price Widget
                Center(
                  child: Text(
                    'Price: NPR ' + price, // Fixed price
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Expanded widget to make the menu scrollable
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Loop through each category and display its items
                        for (var category in menu['categories'])
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category['category'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // Use a Column to display items
                              Column(
                                children: List.generate(
                                  category['items'].length,
                                  (index) {
                                    final item = category['items'][index];
                                    return ListTile(
                                      title: Text(item['name']),
                                      // Assuming you have a 'price' field in your food details
                                      trailing:
                                          Text('${item['price'] ?? 'N/A'}'),
                                    );
                                  },
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _clear() {
    Get.find<VenueMenuController>().onClose();
    Get.find<VenueMenuController>().get();
  }
}
