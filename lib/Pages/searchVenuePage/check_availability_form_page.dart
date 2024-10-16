import 'package:bandobasta/utils/color/colors.dart';
import 'package:bandobasta/utils/dimensions/dimension.dart';
import 'package:bandobasta/widgets/app_text_field.dart';
import 'package:bandobasta/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckAvailabilityPage extends StatefulWidget {
  const CheckAvailabilityPage({super.key});

  @override
  State<CheckAvailabilityPage> createState() => _CheckAvailabilityPageState();
}

class _CheckAvailabilityPageState extends State<CheckAvailabilityPage> {
  var dateController = TextEditingController();
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController();
  var numberOfGuestsController = TextEditingController();

  bool _isDateSelected = false;
  bool _isStartTimeSelected = false;
  bool _isEndTimeSelected = false;

  DateTime _date = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
      child: ListView(
        children: [
          Column(children: [
            Container(
              height: Dimensions.height25,
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(
              textEditingController: numberOfGuestsController,
              hintText: "Guests",
              icon: Icons.people,
              width: Dimensions.width10 * 15,
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(
              textEditingController: dateController,
              hintText: _isDateSelected
                  ? DateFormat.yMMMMd().format(_date)
                  : "MM/DD/YYYY",
              icon: Icons.calendar_today_outlined,
              readOnly: true,
              width: Dimensions.width10 * 15,
              widget: IconButton(
                onPressed: () {
                  _getDate();
                  setState(() {
                    _isDateSelected = true;
                  });
                },
                icon: Icon(
                  Icons.calendar_today_outlined,
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(
              textEditingController: startTimeController,
              hintText: _isStartTimeSelected
                  ? "${_startTime.hour}:${_startTime.minute}"
                  : "Start Time",
              icon: Icons.access_time,
              readOnly: true,
              width: Dimensions.width10 * 15,
              widget: IconButton(
                onPressed: () {
                  _selectStartTime();
                },
                icon: Icon(
                  Icons.access_time,
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(
              textEditingController: endTimeController,
              hintText: _isEndTimeSelected
                  ? "${_endTime.hour}:${_endTime.minute}"
                  : "End Time",
              icon: Icons.access_time,
              readOnly: true,
              width: Dimensions.width10 * 15,
              widget: IconButton(
                onPressed: () {
                  _selectEndTime();
                },
                icon: Icon(
                  Icons.access_time,
                ),
              ),
            ),
          ]),
          SizedBox(
            height: Dimensions.height30,
          ),
          GestureDetector(
            onTap: () {
              // Check availability logic here
            },
            child: Container(
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height50),
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
          SizedBox(
            height: Dimensions.height10,
          ),
        ],
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
        dateController.text = DateFormat.yMMMMd()
            .format(_pickerDate); // Update the date controller text
      });
    }
  }

  _selectStartTime() async {
    TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );

    if (pickedStartTime != null) {
      setState(() {
        _isStartTimeSelected = true;
        _startTime = pickedStartTime;
        startTimeController.text =
            "${pickedStartTime.hour}:${pickedStartTime.minute}"; // Update the start time controller text
      });
    }
  }

  _selectEndTime() async {
    TimeOfDay? pickedEndTime = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );

    if (pickedEndTime != null) {
      setState(() {
        _isEndTimeSelected = true;
        _endTime = pickedEndTime;
        endTimeController.text =
            "${pickedEndTime.hour}:${pickedEndTime.minute}"; // Update the end time controller text
      });
    }
  }

}
