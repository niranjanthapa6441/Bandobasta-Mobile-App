import 'package:bandobasta/Controller/venueController.dart';
import 'package:bandobasta/Response/venueResponse.dart';
import 'package:bandobasta/route_helper/route_helper.dart';
import 'package:bandobasta/utils/app_constants/app_constant.dart';
import 'package:bandobasta/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';

import '../../utils/Color/colors.dart';
import '../../utils/dimensions/dimension.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  final PageController pageController = PageController(viewportFraction: 0.9);
  double _currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height10 * 26,
      width: double.infinity,
      child: _buildVenueList(),
    );
  }

  Widget _buildVenueList() {
    return GetBuilder<VenueController>(builder: (controller) {
      return GestureDetector(
        child: controller.isLoaded
            ? controller.venues.isEmpty
                ? Center(child: Text('No venues available'))
                : Container(
                    height: Dimensions.height10 * 25, // Adjust height if needed
                    padding: EdgeInsets.only(bottom: Dimensions.height20),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal, // Horizontal scrolling
                      itemCount: controller.venues.length + 1,
                      itemBuilder: (context, index) {
                        if (index != controller.totalElements &&
                            index == controller.venues.length) {
                          return Container();
                        } else if (index == controller.totalElements &&
                            index == controller.venues.length) {
                          return Container();
                        }
                        return _buildPopularVenue(
                            index, controller.venues[index]);
                      },
                    ),
                  )
            : _buildLoadingIndicator(),
      );
    });
  }

  Widget _buildPopularVenue(int index, Venue venue) {
    return GestureDetector(
      onTap: () {
        // Add tap action here
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: Dimensions.height5,
          horizontal: Dimensions.width10,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.width10,
        ),
        // Use Flexible or Adjusted Heights
        height: Dimensions.height10 * 25,
        width: Dimensions.width10 * 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 238, 236, 236),
              blurRadius: Dimensions.radius5,
              offset: Offset(0, 5),
            ),
            BoxShadow(
              color: Color.fromARGB(255, 249, 248, 248),
              offset: Offset(-5, 0),
            ),
            BoxShadow(
              color: Color.fromARGB(255, 251, 250, 250),
              offset: Offset(5, 0),
            )
          ],
        ),
        child: Column(
          children: [
            _buildVenueImage(venue.venueImagePaths),
            _buildVenueInfo(venue),
          ],
        ),
      ),
    );
  }

  Widget _buildVenueImage(List<String>? imagePaths) {
    String fallbackImageUrl = "https://via.placeholder.com/300";

    String imageUrl = (imagePaths != null && imagePaths.isNotEmpty)
        ? imagePaths[0]
        : fallbackImageUrl;

    return Container(
      height: Dimensions.height10 * 15,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius10),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              AppConstant.baseURL + AppConstant.apiVersion + imageUrl),
        ),
      ),
    );
  }

  Widget _buildVenueInfo(Venue venue) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.width10, vertical: Dimensions.height10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigText(
              text: venue.name!,
              size: Dimensions.font10 * 1.5,
              textOverflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: Dimensions.height10),
            SmallText(
              text: venue.address!,
              color: Colors.black,
              size: Dimensions.font10 * 1.3,
              textOverflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: Dimensions.height10),
          ],
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
        stops: [0.1, 0.3, 0.4],
        begin: Alignment(-1.0, -0.3),
        end: Alignment(1.0, 0.3),
        tileMode: TileMode.clamp,
      ),
      child: Container(
        height: Dimensions.height10 * 62,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemCount: 5,
          itemBuilder: (_, __) => _buildVenueInfoShimmer(),
        ),
      ),
    );
  }

  Widget _buildVenueInfoShimmer() {
    return Shimmer(
      gradient: const LinearGradient(
        colors: [
          Color(0xFFEBEBF4),
          Color(0xFFF4F4F4),
          Color(0xFFEBEBF4),
        ],
        stops: [0.1, 0.3, 0.4],
        begin: Alignment(-1.0, -0.3),
        end: Alignment(1.0, 0.3),
        tileMode: TileMode.clamp,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Dimensions.height10,
          horizontal: Dimensions.width10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Dimensions.width30 * 8,
              height: Dimensions.height10 * 10,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.radius15),
              ),
            ),
            SizedBox(height: Dimensions.height10),
            Container(
              width: Dimensions.width30 * 8,
              height: Dimensions.height10 * 2.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.radius10),
              ),
            ),
            SizedBox(height: Dimensions.height10),
            Container(
              width: Dimensions.width10 * 20,
              height: Dimensions.height10 * 1.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.radius10),
              ),
            ),
            SizedBox(height: Dimensions.height10),
            Container(
              width: Dimensions.width10 * 15,
              height: Dimensions.height10 * 1.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.radius10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
