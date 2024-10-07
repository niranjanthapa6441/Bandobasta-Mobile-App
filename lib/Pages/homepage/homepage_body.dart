
import 'package:bandobasta/Model/venue.dart';
import 'package:bandobasta/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/Color/colors.dart';
import '../../utils/app_constants/app_constant.dart';
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
  final ScrollController scrollController = ScrollController();
  double _currentPageValue = 0.0;

  static const int _numberOfVenues = 3; // Static number of Venues

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
    scrollController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSectionHeader("Featured Venues"),
        _buildVenueList(),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
  return Container(
    height: Dimensions.height40,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
      children: [
        BigText(text: title), // Left side text
        SmallText(text: "View All ->", color: AppColors.mainBlackColor), 
      ],
    ),
  );
}


  Widget _buildVenueList() {
    List<Venue> venues = [
      Venue(name: 'Fast Food Place', address: '123 Main St', imagePath: 'assets/images/Venue1.png'),
      Venue(name: 'Italian Bistro', address: '456 Elm St', imagePath: 'assets/images/Venue2.png'),
      Venue(name: 'Pasta House', address: '789 Oak St', imagePath: 'assets/images/Venue3.png'),
    ];

    return Container(
      height: Dimensions.height10 * 30, // Adjust the height as needed
      child: ListView.builder(
        controller: scrollController,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const AlwaysScrollableScrollPhysics(), // Enable scrolling
        scrollDirection: Axis.horizontal, // Set horizontal scrolling
        itemCount: _numberOfVenues,
        itemBuilder: (context, index) {
          return _buildPopularVenue(index, venues[index]);
        },
      ),
    );
  }

  Widget _buildPopularVenue(int index, Venue venue) {
    return GestureDetector(
      onTap: () {
        // Add tap action here
        // Get.toNamed(RouteHelper.getVenueMenu());
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: Dimensions.height5,
          horizontal: Dimensions.width10,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.width10,
        ),
        height: Dimensions.height10 * 25,
        width: Dimensions.width10 * 25, // Set width for horizontal layout
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
            _buildVenueImage(venue.imagePath),
            _buildVenueInfo(venue),
          ],
        ),
      ),
    );
  }

  Widget _buildVenueImage(String imagePath) {
    return Container(
      height: Dimensions.height10 * 15,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(AppConstant.baseURL + AppConstant.apiVersion + imagePath),
        ),
        borderRadius: BorderRadius.circular(Dimensions.radius10),
      ),
    );
  }

  Widget _buildVenueInfo(Venue Venue) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigText(
              text: Venue.name,
              size: Dimensions.font10 * 1.5,
              textOverflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: Dimensions.height10),
            SmallText(
              text: Venue.address,
              color: Colors.black,
              size: Dimensions.font10 * 1.3,
              textOverflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: Dimensions.height10),
            _buildVenueStats(),
          ],
        ),
      ),
    );
  }

  Widget _buildVenueStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconAndTextWidget(icon: Icons.star, text: '4.0', size: Dimensions.font10 * 1.3, iconColor: AppColors.iconColor1),
        IconAndTextWidget(icon: Icons.timer, text: '15 mins', size: Dimensions.font10 * 1.3, iconColor: AppColors.mainColor),
        IconAndTextWidget(icon: Icons.location_on, text: '1.5 km', size: Dimensions.font10 * 1.3, iconColor: AppColors.iconColor2),
      ],
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
          padding: EdgeInsets.zero,
          itemCount: 5,
          itemBuilder: (_, __) => _buildSingleLoadingIndicator(),
        ),
      ),
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
        stops: [0.1, 0.3, 0.4],
        begin: Alignment(-1.0, -0.3),
        end: Alignment(1.0, 0.3),
        tileMode: TileMode.clamp,
      ),
      child: Container(
        height: Dimensions.height10 * 25,
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.width10, vertical: Dimensions.height20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Dimensions.height10 * 15,
              width: double.infinity,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: double.infinity, height: 8.0, color: Colors.white),
                  SizedBox(height: Dimensions.height10),
                  Container(width: double.infinity, height: 8.0, color: Colors.white),
                  SizedBox(height: Dimensions.height10),
                  Container(width: double.infinity, height: Dimensions.height10 * 2.4, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
