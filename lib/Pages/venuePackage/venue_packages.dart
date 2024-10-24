import 'package:BandoBasta/Controller/venue_package_controller.dart';
import 'package:BandoBasta/Response/venu_package_response.dart';
import 'package:BandoBasta/card/package_card.dart';
import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class VenuePackagePage extends StatefulWidget {
  final String venueName;

  const VenuePackagePage({super.key, required this.venueName});

  @override
  _VenuePackagePageState createState() => _VenuePackagePageState();
}

class _VenuePackagePageState extends State<VenuePackagePage> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Get.find<VenuePackageController>().onClose();
    Get.find<VenuePackageController>().get();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Get.find<VenuePackageController>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.venueName} Packages'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
              child: GetBuilder<VenuePackageController>(builder: (controller) {
                return GestureDetector(
                  child: controller.isLoaded
                      ? Container(
                          height: Dimensions.height10 * 55,
                          padding: EdgeInsets.only(bottom: Dimensions.height20),
                          child: ListView.builder(
                            controller: _scrollController,
                            padding: EdgeInsets.zero,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: controller.venuePackages.length + 1,
                            itemBuilder: (context, index) {
                              if (index != controller.totalElements &&
                                  index == controller.venuePackages.length) {
                                return _buildSingleLoadingIndicator();
                              } else if (index == controller.totalElements &&
                                  index == controller.venuePackages.length) {
                                return Container();
                              }
                              return _buildPackageCard(
                                  controller.venuePackages[index], index);
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
    if (venueImagePaths != null && venueImagePaths.isNotEmpty) {
      return venueImagePaths[0];
    }
    return null;
  }

  Widget _buildPackageCard(Package detail, int index) {
    return PackageCard(
        imageUrl: AppConstant.baseURL +
            AppConstant.apiVersion +
            getImagePath(detail.hallDetail?.hallImagePaths)!,
        name: detail.name!,
        eventType: detail.eventType!,
        packageType: detail.packageType!,
        capacity: detail.hallDetail!.capacity.toString(),
        description: detail.description!,
        price: detail.price!,
        onViewPackageInfo: () {
          Get.toNamed(RouteHelper.getPackageInfo(index));
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
