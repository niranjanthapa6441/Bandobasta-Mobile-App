import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:BandoBasta/widgets/app_text_field.dart';
import 'package:BandoBasta/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for TextInputFormatter
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckAvailabilityPage extends StatefulWidget {
  const CheckAvailabilityPage({super.key});

  @override
  State<CheckAvailabilityPage> createState() => _CheckAvailabilityPageState();
}

class _CheckAvailabilityPageState extends State<CheckAvailabilityPage> {
  final dateController = TextEditingController();
  final numberOfGuestController = TextEditingController();
  int? guests;
  bool _isDateSelected = false;
  DateTime _date = DateTime.now();
  String? _selectedEventType; // Add variable for selected event type

  final List<String> eventTypes = [
    'Wedding',
    'Birthday',
    'Corporate Event',
    'Party',
    'Rice Feeding Ceremenoy',
    'Bratabanda'
        'Other'
  ]; // List of event types

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
                DropdownButtonFormField<String>(
                  value: _selectedEventType,
                  hint: Text('Select Event Type'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedEventType = newValue;
                    });
                  },
                  items: eventTypes
                      .map<DropdownMenuItem<String>>((String eventType) {
                    return DropdownMenuItem<String>(
                      value: eventType,
                      child: Text(eventType),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: Dimensions.width10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      borderSide: BorderSide(
                          color: AppColors.themeColor), // Make it transparent
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      borderSide: BorderSide(
                          color: AppColors.themeColor), // Use a custom color
                    ),
                  ),
                ),
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
                SizedBox(height: Dimensions.height20),
                AppTextField(
                  textEditingController: numberOfGuestController,
                  width: Dimensions.width10 * 20,
                  hintText: "Number of Guests",
                  icon: Icons.people,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ],
            ),
            SizedBox(height: Dimensions.height30),
            GestureDetector(
              onTap: () {
                if (_isDateSelected &&
                    _isValidNumberOfGuests() &&
                    _selectedEventType != null) {
                  AppConstant.selectedDate =
                      DateFormat('yyyy-MM-dd').format(_date);
                  AppConstant.numberOfGuests = guests!;
                  AppConstant.eventType =
                      _transformEventType(_selectedEventType!);

                  Get.toNamed(RouteHelper.getAvailableDateTime());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            "Please select an event type, date, and valid number of guests")),
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
    DateTime? pickerDate = await showDatePicker(
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
    if (pickerDate != null) {
      setState(() {
        _isDateSelected = true;
        _date = pickerDate;
        dateController.text = DateFormat.yMMMMd().format(pickerDate);
      });
    }
  }

  bool _isValidNumberOfGuests() {
    if (numberOfGuestController.text.isEmpty) {
      return false;
    }
    guests = int.tryParse(numberOfGuestController.text);
    return guests != null && guests! > 0; // Ensure it's a positive integer
  }

  String _transformEventType(String? eventType) {
    switch (eventType) {
      case "Wedding":
        return "WEDDING";
      case "Conference Event":
        return "CONFERENCE_EVENT";
      case "Birthday Party":
        return "BIRTHDAY_PARTY";
      case "Corporate Meeting":
        return "CORPORATE_MEETING";
      case "Bratabanda":
        return "BRATABANDA";
      case "Rice Feeding Ceremony":
        return "RICE_FEEDING_CEREMONY";
      default:
        return eventType!.toUpperCase().replaceAll(' ', '_');
    }
  }
}
