import 'package:bandobasta/Pages/homepage/homepage_body.dart';
import 'package:bandobasta/route_helper/route_helper.dart';
import 'package:bandobasta/utils/color/colors.dart';
import 'package:bandobasta/utils/dimensions/dimension.dart';
import 'package:bandobasta/widgets/big_text.dart';
import 'package:bandobasta/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../utils/app_constants/app_constant.dart';

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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: Dimensions.height50, bottom: Dimensions.height10),
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(children: [
                    Container(
                      child: BigText(
                        text: "Bandobasta",
                        textOverflow: TextOverflow.ellipsis,
                        size: Dimensions.font20,
                        color: AppColors.mainBlackColor,
                      ),
                      width: Dimensions.width10 * 25,
                    )
                  ]),
                  height: Dimensions.height30,
                  width: Dimensions.width300,
                ),
                Stack(
                  children: [
                    AppConstant.hasValue
                        ? Positioned(
                            child: IconButton(
                              onPressed: () {
                                Get.toNamed(RouteHelper.getCart());
                                AppConstant.toCart = false;
                              },
                              icon: Icon(
                                Icons.shopping_cart,
                                size: Dimensions.height30,
                                color: AppColors.mainColor,
                              ),
                            ),
                          )
                        : Positioned(
                            child: IconButton(
                              onPressed: () {
                                Get.toNamed(RouteHelper.getCart());
                                AppConstant.toCart = false;
                              },
                              icon: Icon(
                                Icons.shopping_cart,
                                size: Dimensions.height30,
                                color: Colors.black,
                              ),
                            ),
                          ),
                    AppConstant.hasValue
                        ? Positioned(
                            top: 0,
                            right: 0,
                            child: BigText(
                              text: AppConstant.numberOfItems,
                              color: Colors.black,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: Dimensions.height10),
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.only(left: Dimensions.width10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: AppColors.themeColor,
                            ),
                            SizedBox(
                              width: Dimensions.width10,
                            ),
                            SmallText(
                              text: "Search for venues, photographers, DJs, more...",
                              size: Dimensions.font12,
                              color: AppColors.mainBlackColor,
                            )
                          ],
                        ),
                        height: Dimensions.height50,
                        width: Dimensions.width10 * 35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 8,
                                  spreadRadius: 6,
                                  offset: Offset(1, 8),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                      ),
                      onTap: () {
                        Get.toNamed(RouteHelper.getSearchFoods());
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
              child: HomePageBody(),
          )),
        ],
      ),
    );
  }
}
