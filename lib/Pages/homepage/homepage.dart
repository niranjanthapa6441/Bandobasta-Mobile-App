import 'package:BandoBasta/Pages/homepage/homepage_body.dart';
import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:BandoBasta/widgets/big_text.dart';
import 'package:BandoBasta/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: Dimensions.height10 * 8,
          automaticallyImplyLeading: false,
          elevation: 0, // No shadow
          backgroundColor: Colors.white,
          title: Center(
            child: Container(
              height: Dimensions.height10 * 9,
              width: Dimensions.height10 * 20, // Adjust the width if needed
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain, // Use contain to fit the whole image
                  image:
                      AssetImage("assets/images/logo.png"), // Your logo image
                ),
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: Dimensions.height20),
                child: BigText(
                  text: "What are you thinking of booking today?",
                  size: Dimensions.font15 + 2,
                  color: AppColors.mainBlackColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              Container(
                margin: EdgeInsets.only(
                    bottom: Dimensions.height20, top: Dimensions.height10),
                child: GestureDetector(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: Dimensions.width10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: AppColors.themeColor,
                        ),
                        SizedBox(
                          width: Dimensions.width5,
                        ),
                        SmallText(
                          text: "Search for venues, photographers, DJs, more..",
                          size: Dimensions.font12,
                          color: AppColors.mainBlackColor,
                        ),
                      ],
                    ),
                    height: Dimensions.height50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          spreadRadius: 6,
                          offset: Offset(1, 8),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(RouteHelper.getSearchVenue());
                  },
                ),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              Container(
                height: Dimensions.height20 * 10,
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: Dimensions.height20,
                  crossAxisSpacing: Dimensions.width20,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getSearchVenue());
                      },
                      child: serviceItem(Icons.location_city, "Venue"),
                    ),
                    serviceItem(Icons.camera_alt, "Photographer"),
                    serviceItem(Icons.brush, "Henna Artist"),
                    serviceItem(Icons.face, "Bridal Makeup"),
                    serviceItem(Icons.person, "Priest"),
                    serviceItem(Icons.music_note, "DJ Service"),
                    serviceItem(Icons.card_giftcard, "Decoration"),
                    serviceItem(Icons.diamond, "Jewellery"),
                  ],
                ),
              ),
              _buildSectionHeader('Featured Venues'),
              Expanded(
                child: SingleChildScrollView(
                  child: HomePageBody(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      height: Dimensions.height40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BigText(text: title),
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getSearchVenue());
            },
            child: SmallText(
              text: "View All ->",
              color: AppColors.mainBlackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget serviceItem(IconData icon, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: AppColors.themeColor,
          radius: Dimensions.radius15 + 13,
          child: Icon(
            icon,
            color: Colors.white,
            size: Dimensions.height20 + 4,
          ),
        ),
        SizedBox(height: Dimensions.height5),
        BigText(
          text: title,
          color: AppColors.mainBlackColor,
          size: Dimensions.font10,
          fontWeight: FontWeight.bold,
          maxLines: 2,
          textOverflow: TextOverflow.ellipsis, // Adjusted title size
        ),
      ],
    );
  }
}
