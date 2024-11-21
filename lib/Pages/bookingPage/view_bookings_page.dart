import 'package:BandoBasta/Controller/booking_controller.dart';
import 'package:BandoBasta/Pages/bookingPage/booking_page_body.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utils/app_constants/app_constant.dart';
import '../../utils/dimensions/dimension.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _OrdersState();
}

class _OrdersState extends State<BookingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _clear();
    super.dispose();
  }

  List<String> status = ['All', 'Pending', 'Booked', 'Cancelled'];
  int _selectedIndex = 0;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  bool _startDateSelected = false;
  bool _endDateSelected = false;
  bool _isLoading = false;

  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          children: [
            AppBar(
              toolbarHeight: Dimensions.height10 * 8,
              automaticallyImplyLeading: false,
              elevation: 0, // No shadow
              backgroundColor: Colors.white,
              title: Center(
                child: Container(
                  height: Dimensions.height10 * 9,
                  width: Dimensions.height10 * 20,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage("assets/images/logo.png"),
                    ),
                  ),
                ),
              ),
              centerTitle: true,
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            Container(
              height: Dimensions.height10 * 5,
              width: Dimensions.screenWidth,
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: status.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildCategories(index, status[index]);
                },
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: AppTextField(
                    textEditingController: _startDateController,
                    hintText: _startDateSelected
                        ? DateFormat.yMMMMd().format(_startDate)
                        : "MM/DD/YYYY",
                    icon: Icons.calendar_today_outlined,
                    readOnly: true,
                    width: Dimensions.width10 * 14,
                    widget: IconButton(
                      onPressed: () {
                        _getStartDate();
                        setState(() {
                          _startDateSelected = true;
                        });
                        _filerOrders();
                      },
                      icon: Icon(
                        Icons.calendar_today_outlined,
                        color: AppColors.themeColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Dimensions.width15,
                ),
                Flexible(
                  child: AppTextField(
                    textEditingController: _endDateController,
                    hintText: _endDateSelected
                        ? DateFormat.yMMMMd().format(_endDate)
                        : "MM/DD/YYYY",
                    icon: Icons.calendar_today_outlined,
                    readOnly: true,
                    width: Dimensions.width10 * 14,
                    widget: IconButton(
                      onPressed: () {
                        _getEndDate();
                      },
                      icon: Icon(
                        Icons.calendar_today_outlined,
                        color: AppColors.themeColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                          color: AppColors.themeColor))
                  : SingleChildScrollView(child: BookingsPageBody()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories(int index, String status) {
    bool isSelected = index == _selectedIndex;
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(
          top: Dimensions.height5,
          bottom: Dimensions.height5,
          left: Dimensions.width5,
        ),
        padding: EdgeInsets.only(
          left: Dimensions.width10,
          right: Dimensions.width10,
        ),
        height: Dimensions.height10,
        decoration: BoxDecoration(
          color: !isSelected
              ? Color.fromARGB(255, 255, 255, 255)
              : AppColors.themeColor,
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
        child: Center(
            child: BigText(
          text: status,
          size: Dimensions.font15,
          color: !isSelected ? Colors.black : Colors.white,
        )),
      ),
      onTap: () {
        setState(() {
          _selectedIndex = index;
          _isLoading = true;
          _filerOrders();
        });
      },
    );
  }

  _filerOrders() {
    if (_selectedIndex == 0) {
      AppConstant.bookingStatus = '';
    } else {
      if (status[_selectedIndex] == 'Pending') {
        AppConstant.bookingStatus = 'PENDING';
      } else if (status[_selectedIndex] == 'Booked') {
        AppConstant.bookingStatus = 'BOOKED';
      } else if (status[_selectedIndex] == 'Cancelled') {
        AppConstant.bookingStatus = 'CANCELLED';
      }
    }
    if (_startDateSelected == true) {
      AppConstant.startDate = _startDate.toString().substring(0, 10);
    }
    if (_endDateSelected == true) {
      if (_endDate.isAfter(_startDate)) {
        AppConstant.endDate = _endDate.toString().substring(0, 10);
      }
    }
    Get.find<BookingController>().onClose();
    Get.find<BookingController>().get();
    _isLoading = false;
  }

  _getStartDate() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365 * 2)),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(primary: AppColors.themeColor),
          ),
          child: child!,
        );
      },
    );
    if (_pickerDate != null) {
      setState(() {
        _startDateSelected = true;
        _startDate = _pickerDate;
      });
    }
  }

  _getEndDate() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365 * 2)),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(primary: AppColors.themeColor),
          ),
          child: child!,
        );
      },
    );

    if (_pickerDate != null) {
      if (_pickerDate.isBefore(_startDate)) {
        Get.snackbar(
            "Invalid Date", "End date must be greater than start date.",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      } else {
        setState(() {
          _endDateSelected = true;
          _endDate = _pickerDate;
          _filerOrders();
        });
      }
    }
  }

  void _clear() {
    AppConstant.startDate = '';
    AppConstant.endDate = '';
    AppConstant.bookingStatus = '';
    Get.find<BookingController>().onClose();
    Get.find<BookingController>().get();
  }
}
