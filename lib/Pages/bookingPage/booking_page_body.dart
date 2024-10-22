import 'package:bandobasta/Controller/booking_controller.dart';
import 'package:bandobasta/Response/hall_booking_response.dart';
import 'package:bandobasta/route_helper/route_helper.dart';
import 'package:bandobasta/utils/app_constants/app_constant.dart';
import 'package:bandobasta/utils/color/colors.dart';
import 'package:bandobasta/utils/dimensions/dimension.dart';
import 'package:bandobasta/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../widgets/small_text.dart';

class BookingsPageBody extends StatefulWidget {
  const BookingsPageBody({super.key});

  @override
  State<BookingsPageBody> createState() => _OrdersPageBodyState();
}

class _OrdersPageBodyState extends State<BookingsPageBody> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Get.find<BookingController>().onClose();
    Get.find<BookingController>().get();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
    Get.find<BookingController>().onClose();
    Get.find<BookingController>().get();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Get.find<BookingController>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   height: Dimensions.height10 * 20,
        //   width: Dimensions.width10 * 300,
        //   decoration: BoxDecoration(
        //     color: AppColors.themeColor,
        //   ),
        //   child: Container(
        //     margin: EdgeInsets.only(
        //         top: Dimensions.height20, left: Dimensions.width20),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         BigText(
        //           text: "Pending Orders",
        //           color: Colors.white,
        //         ),
        //         SizedBox(
        //           height: Dimensions.height50,
        //         ),
        //         Center(
        //           child: BigText(
        //             text: "You Don't have any recent orders",
        //             color: Colors.white,
        //             size: Dimensions.font10 * 1.4,
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        if (AppConstant.isUserLoggedIn)
          Container(
            margin: EdgeInsets.only(
                top: Dimensions.height10, left: Dimensions.width10),
            child: BigText(
              text: "Booking History",
              size: Dimensions.font20,
              color: Colors.black,
            ),
          ),
        if (AppConstant.isUserLoggedIn)
          GetBuilder<BookingController>(builder: (orders) {
            return GestureDetector(
              child: orders.isLoaded
                  ? Container(
                      height: Dimensions.height10 * 55,
                      padding: EdgeInsets.only(bottom: Dimensions.height20),
                      child: ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.zero,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: orders.customerOrderDetails.length + 1,
                          itemBuilder: (context, index) {
                            if (index != orders.totalElements &&
                                index == orders.customerOrderDetails.length) {
                              return _buildSingleLoadingIndicator();
                            } else if (index == orders.totalElements &&
                                index == orders.customerOrderDetails.length) {
                              return Container();
                            }
                            return _buildCustomerBookingDetailItemPage(
                                index, orders.customerOrderDetails[index]);
                          }),
                    )
                  : _buildLoadingIndicator(),
            );
          }),
      ],
    );
  }

  Widget _buildCustomerBookingDetailItemPage(int index, Booking orders) {
    String orderDate = orders.bookedForDate.toString();
    DateTime dateTime = DateTime.parse(orderDate);
    int year = dateTime.year;
    String monthName = DateFormat('MMMM').format(dateTime);
    int day = dateTime.day;
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(
            left: Dimensions.width10,
            right: Dimensions.width10,
            top: Dimensions.height10,
            bottom: Dimensions.height10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          color: Color.fromARGB(255, 255, 255, 255),
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
        height: Dimensions.width10 * 20,
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  //imageContainer
                  Container(
                    width: Dimensions.width10 * 11,
                    height: Dimensions.height10 * 12,
                    margin: EdgeInsets.only(
                        left: Dimensions.width10,
                        right: Dimensions.width10,
                        bottom: Dimensions.height10,
                        top: Dimensions.height10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BigText(
                          text: day.toString(),
                          color: Color.fromARGB(255, 9, 9, 9),
                          size: Dimensions.font30,
                        ),
                        SmallText(
                          text: monthName,
                          color: Color.fromARGB(255, 9, 9, 9),
                          size: Dimensions.font10 * 1.8,
                        ),
                        SmallText(
                          text: year.toString(),
                          color: Color.fromARGB(255, 14, 13, 13),
                          size: Dimensions.font10 * 1.6,
                        )
                      ],
                    ),
                  ),
                  //textContainer
                  Expanded(
                    child: Container(
                      width: Dimensions.width30 * 30,
                      height: Dimensions.height10 * 19,
                      padding: EdgeInsets.only(top: Dimensions.height10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SmallText(
                            text: "Venue Name: ",
                            color: AppColors.mainBlackColor,
                            size: Dimensions.font10 * 1.6,
                          ),
                          SizedBox(
                            height: Dimensions.height15,
                          ),
                          SmallText(
                            text: "Hall: ",
                            color: AppColors.mainBlackColor,
                            size: Dimensions.font10 * 1.6,
                          ),
                          SizedBox(
                            height: Dimensions.height15,
                          ),
                          SmallText(
                            text: "Menu: ",
                            color: AppColors.mainBlackColor,
                            size: Dimensions.font10 * 1.6,
                          ),
                          SizedBox(
                            height: Dimensions.height15,
                          ),
                          SmallText(
                            text: "Status: ",
                            color: AppColors.mainBlackColor,
                            size: Dimensions.font10 * 1.6,
                          ),
                          SizedBox(
                            height: Dimensions.height20 * 0.92,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: Dimensions.height10),
                      width: Dimensions.width30 * 30,
                      height: Dimensions.height10 * 19,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SmallText(
                            text: orders.venueName!,
                            color: AppColors.mainBlackColor,
                            size: Dimensions.font10 * 1.6,
                          ),
                          SizedBox(
                            height: Dimensions.height15,
                          ),
                          SmallText(
                            text: orders.hallDetail!.name!,
                            color: AppColors.mainBlackColor,
                            size: Dimensions.font10 * 1.6,
                          ),
                          SizedBox(
                            height: Dimensions.height15,
                          ),
                          SmallText(
                            text: orders.menuDetail!.menuType!,
                            color: AppColors.mainBlackColor,
                            size: Dimensions.font10 * 1.6,
                          ),
                          SizedBox(
                            height: Dimensions.height15,
                          ),
                          SmallText(
                            text: orders.status.toString(),
                            color: AppColors.mainBlackColor,
                            size: Dimensions.font10 * 1.6,
                          ),
                          SizedBox(
                            height: Dimensions.height20 * 0.92,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SmallText(
                                text: "Show More",
                                color: AppColors.mainBlackColor,
                                size: Dimensions.font15,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: AppColors.mainBlackColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () => Get.toNamed(RouteHelper.getOrderDetail(index)),
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

          itemCount: 5, // You can adjust the number of shimmering cells
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
}
