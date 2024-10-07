import 'package:bandobasta/Pages/homepage/homepage_body.dart';
import 'package:bandobasta/route_helper/route_helper.dart';
import 'package:bandobasta/utils/color/colors.dart';
import 'package:bandobasta/utils/dimensions/dimension.dart';
import 'package:bandobasta/widgets/big_text.dart';
import 'package:bandobasta/widgets/small_text.dart';
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80), // Increased height for the app bar
        child: AppBar(
          elevation: 0, // No shadow
          backgroundColor: Colors.white, // White background
          title: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.themeColor, // Background color for the logo
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0), // Padding around logo
                  // Uncomment and adjust the logo image path as needed
                  // child: Image.asset(
                  //   'assets/images/logo.png', // Adjust to your logo path
                  //   width: 40, // Adjust as needed
                  //   height: 40, // Adjust as needed
                  // ),
                ),
              ),
              SizedBox(width: 10), // Space between logo and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                    text: "BANDOBASTA",
                    color: AppColors.themeColor, // Color for the title
                    size: Dimensions.font20,
                    fontWeight: FontWeight.w900, // Adjust the size
                  ),
                  SmallText(
                    text: "Effortless booking",
                    color: AppColors.themeColor, // Color for the subtitle
                    size: Dimensions.font12, // Adjust the size
                  ),
                ],
              ),
            ],
          ),
        ),
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
                size: Dimensions.font15, 
                color: AppColors.mainBlackColor, 
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: Dimensions.height20, top: Dimensions.height10),
              child: GestureDetector(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width10), // Use symmetric padding
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
                        text: "Search for venues, photographers, DJs, more...",
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
                  Get.toNamed(RouteHelper.getSearchFoods());
                },
              ),
            ),
            // New Services Section with 4x2 Grid
            Container(
              height: 200, // Set a fixed height for the services section
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 4, // 4 columns
                childAspectRatio: 1.0,
                mainAxisSpacing: Dimensions.height20, // Increase vertical space
                crossAxisSpacing: Dimensions.width20, // Increase horizontal space
                children: [
                  serviceItem(Icons.location_city, "Venue"),
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
            Expanded(
              child: SingleChildScrollView(
                child: HomePageBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget serviceItem(IconData icon, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: AppColors.themeColor,
          radius: 30, // Increased size for larger icon
          child: Icon(
            icon,
            color: Colors.white,
            size: 24, // Larger icon size
          ),
        ),
        SizedBox(height: Dimensions.height5),
        BigText(
          text: title,
          color: AppColors.mainBlackColor,
          size: Dimensions.font10,
          maxLines: 2, 
          textOverflow: TextOverflow.ellipsis,// Adjusted title size
        ),
      ],
    );
  }
}
