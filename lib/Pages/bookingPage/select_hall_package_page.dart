import 'package:BandoBasta/Controller/venue_hall_controller.dart';
import 'package:BandoBasta/Controller/venue_package_controller.dart';
import 'package:BandoBasta/Response/venu_package_response.dart';
import 'package:BandoBasta/Response/venue_hall_response.dart' as VH;
import 'package:BandoBasta/card/hall_card.dart';
import 'package:BandoBasta/card/package_card.dart';
import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/app_constants/app_constant.dart';
import '../../utils/dimensions/dimension.dart';
import '../../widgets/big_text.dart';

class SelectHallPackagePage extends StatefulWidget {
  final String venueName;
  final String imageURL;
  const SelectHallPackagePage(
      {super.key, required this.venueName, required this.imageURL});

  @override
  State<SelectHallPackagePage> createState() => _SelectHallPackagePageState();
}

class _SelectHallPackagePageState extends State<SelectHallPackagePage> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Get.find<VenueHallController>().onClose();
    Get.find<VenueHallController>().get();
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
      if (Get.find<VenueHallController>().isLoaded && _selectedIndex == 0) {
        Get.find<VenueHallController>().loadMore();
      }

      if (Get.find<VenuePackageController>().isLoaded && _selectedIndex == 1) {
        Get.find<VenuePackageController>().loadMore();
      }
    }
  }

  List<String> bookingType = ['Hall', 'Package', 'Customize'];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            title: BigText(
              text: "Choose Halls, Packages, or Customize",
              color: Colors.white,
              size: Dimensions.font10 * 1.6,
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                AppConstant.isSelectHallPackageSelected = false;
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(
            height: Dimensions.height10,
          ),
          Container(
            height: Dimensions.height10 * 5,
            width: Dimensions.screenWidth,
            margin: EdgeInsets.only(
                top: Dimensions.height10, left: Dimensions.width10),
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: bookingType.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildCategories(index, bookingType[index]);
              },
            ),
          ),
          SizedBox(
            height: Dimensions.height10,
          ),
          Container(
            margin: EdgeInsets.only(
                top: Dimensions.height10, left: Dimensions.width10),
            child: BigText(
              text: "Featured",
              size: Dimensions.font20,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: _loadContent(),
          )
        ],
      ),
    );
  }

  Widget _buildCategories(int index, String type) {
    bool isSelected = index == _selectedIndex;
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(
          top: Dimensions.height5,
          bottom: Dimensions.height5,
        ),
        padding: EdgeInsets.only(
          left: Dimensions.width10,
          right: Dimensions.width10,
        ),
        height: Dimensions.height10,
        decoration: BoxDecoration(
          color: !isSelected ? Colors.white : AppColors.themeColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: Dimensions.radius5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Center(
            child: BigText(
          text: type,
          size: Dimensions.font15,
          color: !isSelected ? Colors.black : Colors.white,
        )),
      ),
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }

  Widget _loadContent() {
    if (_selectedIndex == 0) {
      return _loadHalls();
    } else if (_selectedIndex == 1) {
      _clear();
      return _loadPackages();
    } else {
      return _loadCustomization();
    }
  }

  Widget _loadHalls() {
    return GetBuilder<VenueHallController>(builder: (controller) {
      return GestureDetector(
        child: controller.isLoaded
            ? Container(
                height: Dimensions.height10 * 55,
                padding: EdgeInsets.only(
                    left: Dimensions.width10,
                    right: Dimensions.width10,
                    bottom: Dimensions.height20),
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
                    return _buildHallCard(controller.venueHalls[index], index);
                  },
                ),
              )
            : _buildLoadingIndicator(),
      );
    });
  }

  Widget _buildHallCard(VH.HallDetail detail, int index) {
    return HallCard(
        imageUrl: AppConstant.baseURL +
            AppConstant.apiVersion +
            getImagePath(detail.hallImagePaths)!,
        name: detail.name!,
        floorNumber: detail.floorNumber!,
        capacity: detail.capacity.toString(),
        description: detail.description!,
        onViewHallInfo: () {
          AppConstant.hallDetail = detail;
          AppConstant.hallIndex = index;
          Get.toNamed(RouteHelper.getHallInfo(
              index, widget.venueName, widget.imageURL));
        });
  }

  String? getImagePath(List<String>? venueImagePaths) {
    if (venueImagePaths != null && venueImagePaths.isNotEmpty) {
      return venueImagePaths[0];
    }
    return null;
  }

  Widget _loadPackages() {
    return GetBuilder<VenuePackageController>(builder: (controller) {
      return GestureDetector(
        child: controller.isLoaded
            ? Container(
                height: Dimensions.height10 * 55,
                padding: EdgeInsets.only(
                    left: Dimensions.width10,
                    right: Dimensions.width10,
                    bottom: Dimensions.height20),
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
    });
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
          Get.toNamed(RouteHelper.getPackageInfo(index,widget.venueName,widget.imageURL));
        });
  }

  Widget _loadCustomization() {
    return Center(
      child: Text('Customization Options'),
    );
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
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 8,
        itemBuilder: (context, index) {
          return Container(
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
                          height: 8.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _clear() {
    Get.find<VenueHallController>().onClose();
    Get.find<VenueHallController>().get();
    Get.find<VenuePackageController>().onClose();
    Get.find<VenuePackageController>().get();
  }
}
