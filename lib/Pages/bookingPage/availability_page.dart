import 'package:BandoBasta/Controller/check_hall_availability_controller.dart';
import 'package:BandoBasta/Response/hall_availability_response.dart';
import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:BandoBasta/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class AvailabilityPage extends StatefulWidget {
  const AvailabilityPage({Key? key}) : super(key: key);

  @override
  _AvailabilityPageState createState() => _AvailabilityPageState();
}

class _AvailabilityPageState extends State<AvailabilityPage> {
  List<DateTime> upcomingDates = [];
  late DateTime selectedDate;
  late DateTime currentMonth;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.parse(AppConstant.selectedDate);
    currentMonth = DateTime.parse(AppConstant.selectedDate);
    Get.find<HallAvailabilityController>().onClose();
    Get.find<HallAvailabilityController>().get();
    _generateUpcomingDates();
  }

  void _generateUpcomingDates() {
    upcomingDates.clear();
    DateTime baseDate = selectedDate;

    for (int i = -10; i <= 10; i++) {
      upcomingDates.add(baseDate.add(Duration(days: i)));
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate();
    });
  }

  void _scrollToSelectedDate() {
    int index =
        upcomingDates.indexWhere((date) => date.isAtSameMomentAs(selectedDate));
    if (index != -1) {
      double itemWidth = Dimensions.width10 * 9;
      double offset = index * itemWidth;
      offset = offset.clamp(0.0, _scrollController.position.maxScrollExtent);

      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Date and Time'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            AppConstant.isSelectHallPackageSelected = true;
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildMonthYearBar(),
            _buildDateCarousel(),
            GetBuilder<HallAvailabilityController>(builder: (availabilities) {
              return GestureDetector(
                child: availabilities.isLoaded
                    ? availabilities.hallAvailabilities.isEmpty
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            alignment: Alignment.center,
                            child: Text(
                              "No slots available. Select another date",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          )
                        : Container(
                            height: Dimensions.height10 * 55,
                            padding:
                                EdgeInsets.only(bottom: Dimensions.height20),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                physics:
                                    const NeverScrollableScrollPhysics(), 
                                shrinkWrap:
                                    true, 
                                itemCount:
                                    availabilities.hallAvailabilities.length,
                                itemBuilder: (context, index) {
                                  if (index <
                                      availabilities
                                          .hallAvailabilities.length) {
                                    return _buildTimeRow(availabilities
                                        .hallAvailabilities[index]);
                                  } else {
                                    return Container();
                                  }
                                }),
                          )
                    : _buildLoadingIndicator(),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeRow(HallAvailabilityDetail availability) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.height5),
      padding: EdgeInsets.all(Dimensions.height10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(text: availability.startTime!),
              SizedBox(width: Dimensions.width10),
              BigText(text: '-'),
              SizedBox(width: Dimensions.width10),
              BigText(text: availability.endTime!),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              AppConstant.isSelectHallPackageSelected = false;
              AppConstant.selectedTime =
                  "${availability.startTime!} - ${availability.endTime!}";
              AppConstant.hallAvailabilityId = availability.id!;
              Get.toNamed(RouteHelper.getBookingConfirmationPage());
            },
            child: Text('Book'),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthYearBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimensions.width10),
      child: Text(
        DateFormat.yMMMM().format(currentMonth),
        style: TextStyle(
          fontSize: Dimensions.font10*2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDateCarousel() {
    return Container(
      height: Dimensions.height10 * 14,
      padding: EdgeInsets.symmetric(vertical: Dimensions.height10),
      margin: EdgeInsets.symmetric(vertical: Dimensions.height10),
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: upcomingDates.length,
        itemBuilder: (context, index) {
          DateTime date = upcomingDates[index];
          bool isSelected = date.isAtSameMomentAs(selectedDate);

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = date;
                currentMonth = DateTime(date.year, date.month);
                AppConstant.selectedDate =
                    DateFormat('yyyy-MM-dd').format(date).toString();
                Get.find<HallAvailabilityController>().onClose();
                Get.find<HallAvailabilityController>().get();
                _scrollToSelectedDate(); // Center the selected date after selection
              });
            },
            child: Container(
              width: Dimensions.width10 * 9,
              margin:
                  EdgeInsets.symmetric(horizontal: Dimensions.width10 * 0.8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: isSelected
                        ? Dimensions.width10 * 9
                        : Dimensions.width10 * 8,
                    height: isSelected
                        ? Dimensions.height10 * 9
                        : Dimensions.height10 * 8,
                    padding: EdgeInsets.all(Dimensions.height10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.themeColor
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        DateFormat.d().format(date),
                        style: TextStyle(
                          fontSize: Dimensions.font10 * 2.4,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.height10 * 0.5),
                  BigText(
                    text: DateFormat.E().format(date),
                    size: Dimensions.font10 * 1.8,
                    color: isSelected ? AppColors.themeColor : Colors.black,
                  ),
                ],
              ),
            ),
          );
        },
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
        height: Dimensions.height10 * 30,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 5, // Adjust this number as needed
          itemBuilder: (context, index) {
            return Container(
              height: Dimensions.height10 * 5,
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: Dimensions.height5),
            );
          },
        ),
      ),
    );
  }
}
