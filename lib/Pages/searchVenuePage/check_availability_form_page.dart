import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:BandoBasta/widgets/app_text_field.dart';
import 'package:BandoBasta/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckAvailabilityPage extends StatefulWidget {
  const CheckAvailabilityPage({super.key});

  @override
  State<CheckAvailabilityPage> createState() => _CheckAvailabilityPageState();
}

class _CheckAvailabilityPageState extends State<CheckAvailabilityPage> {
  final dateController = TextEditingController();
  bool _isDateSelected = false;
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Date'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(
          left: Dimensions.width10,
          right: Dimensions.width10,
        ),
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(height: Dimensions.height25),
                SizedBox(height: Dimensions.height20),
                SizedBox(height: Dimensions.height20),
                AppTextField(
                  textEditingController: dateController,
                  hintText: _isDateSelected
                      ? DateFormat.yMMMMd().format(_date)
                      : "MM/DD/YYYY",
                  icon: Icons.calendar_today_outlined,
                  readOnly: true,
                  width: Dimensions.width10 * 20,
                  widget: IconButton(
                    onPressed: () {
                      _getDate();
                    },
                    icon: Icon(Icons.calendar_today_outlined),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.height30),
            GestureDetector(
              onTap: () {
                if (_isDateSelected) {
                  AppConstant.selectedDate =
                      DateFormat('yyyy-MM-dd').format(_date);
                  Get.toNamed(RouteHelper.getAvailableDateTime());
                } else {
                  // Show a message if selection is incomplete
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text("Please select an event type and date")),
                  );
                }
              },
              child: Container(
                margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height50,
                ),
                height: Dimensions.screenHeight / 14,
                width: Dimensions.width20 * 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: AppColors.themeColor,
                ),
                child: Center(
                  child: BigText(
                    text: "Check Availability",
                    size: Dimensions.font15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10),
          ],
        ),
      ),
    );
  }

  _getDate() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // Prevent selecting past dates
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: AppColors.themeColor, // Change the primary color here
            ),
          ),
          child: child!,
        );
      },
    );
    if (_pickerDate != null) {
      setState(() {
        _isDateSelected = true;
        _date = _pickerDate;
        dateController.text = DateFormat.yMMMMd().format(_pickerDate);
      });
    }
  }
}
