import 'package:BandoBasta/Controller/venue_hall_controller.dart';
import 'package:BandoBasta/Response/venue_hall_response.dart';
import 'package:BandoBasta/card/hall_card.dart';
import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class VenueHallPage extends StatefulWidget {
  final String venueName;
  final String imageURL;

  const VenueHallPage(
      {super.key, required this.venueName, required this.imageURL});

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

  String? getImagePath(List<String>? hallImagePaths) {
    if (hallImagePaths != null && hallImagePaths.isNotEmpty) {
      return hallImagePaths[0];
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
          Get.toNamed(RouteHelper.getHallInfo(
              index, widget.venueName, widget.imageURL));
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
