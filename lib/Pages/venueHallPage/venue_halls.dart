import 'package:bandobasta/Controller/venue_hall_controller.dart';
import 'package:bandobasta/Response/venue_hall_response.dart';
import 'package:bandobasta/route_helper/route_helper.dart';
import 'package:bandobasta/utils/app_constants/app_constant.dart';
import 'package:bandobasta/utils/color/colors.dart';
import 'package:bandobasta/utils/dimensions/dimension.dart';
import 'package:bandobasta/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class VenueHallPage extends StatefulWidget {
  final String venueName;

  const VenueHallPage({super.key, required this.venueName});

  @override
  _VenueHallPageState createState() => _VenueHallPageState();
}

class _VenueHallPageState extends State<VenueHallPage> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Get.find<VenueHallController>().onClose();
    Get.find<VenueHallController>().get();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Get.find<VenueHallController>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.venueName + ' Halls'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GetBuilder<VenueHallController>(builder: (controller) {
                return GestureDetector(
                  child: controller.isLoaded
                      ? Container(
                          height: Dimensions.height10 * 55,
                          padding: EdgeInsets.only(bottom: Dimensions.height20),
                          child: ListView.builder(
                            controller: _scrollController,
                            padding: EdgeInsets.zero,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: controller.venueHalls.length + 1,
                            itemBuilder: (context, index) {
                              if (index != controller.totalElements &&
                                  index == controller.venueHalls.length) {
                                return _buildSingleLoadingIndicator();
                              } else if (index == controller.totalElements &&
                                  index == controller.venueHalls.length) {
                                return Container();
                              }
                              return _buildHallCard(
                                  controller.venueHalls[index], index);
                            },
                          ),
                        )
                      : _buildLoadingIndicator(),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  String? getImagePath(List<String>? venueImagePaths) {
    if (venueImagePaths != null && venueImagePaths!.isNotEmpty) {
      return venueImagePaths![0];
    }
    return null;
  }

  Widget _buildHallCard(HallDetail detail, int index) {
    return HallCard(
        imageUrl: AppConstant.baseURL +
            AppConstant.apiVersion +
            getImagePath(detail.hallImagePaths)!,
        name: detail.name!,
        floorNumber: detail.floorNumber!,
        capacity: detail.capacity.toString(),
        description: detail.description!,
        onViewHallInfo: () {
          Get.toNamed(RouteHelper.getHallInfo(index));
        });
  }

  Widget _buildSingleLoadingIndicator() {
    return Shimmer(
      gradient: const LinearGradient(
        colors: [
          Color(0xFFEBEBF4),
          Color(0xFFF4F4F4),
          Color(0xFFEBEBF4),
        ],
        stops: [
          0.1,
          0.3,
          0.4,
        ],
        begin: Alignment(-1.0, -0.3),
        end: Alignment(1.0, 0.3),
        tileMode: TileMode.clamp,
      ),
      child: Container(
        height: Dimensions.height10 * 13,
        child: Container(
          padding: EdgeInsets.only(
              right: Dimensions.width10,
              left: Dimensions.width10,
              bottom: Dimensions.height20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Dimensions.height10 * 10,
                width: Dimensions.width10 * 10,
                color: Colors.white,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Container(
                      width: double.infinity,
                      height: Dimensions.height10 * 2.4,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Container(
                      width: 40.0,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Shimmer(
      gradient: const LinearGradient(
        colors: [
          Color(0xFFEBEBF4),
          Color(0xFFF4F4F4),
          Color(0xFFEBEBF4),
        ],
        stops: [
          0.1,
          0.3,
          0.4,
        ],
        begin: Alignment(-1.0, -0.3),
        end: Alignment(1.0, 0.3),
        tileMode: TileMode.clamp,
      ),
      child: Container(
        height: Dimensions.height10 * 62,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 5,
          itemBuilder: (_, __) => Container(
            padding: EdgeInsets.only(
                right: Dimensions.width10,
                left: Dimensions.width10,
                bottom: Dimensions.height20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Dimensions.height10 * 10,
                  width: Dimensions.width10 * 10,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Container(
                        width: double.infinity,
                        height: Dimensions.height10 * 2.4,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Container(
                        width: 40.0,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// VenueCard Widget
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
