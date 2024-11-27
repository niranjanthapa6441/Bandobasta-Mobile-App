import 'package:BandoBasta/Pages/homepage/homepage_body.dart';
import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:BandoBasta/widgets/app_text_field.dart';
import 'package:BandoBasta/widgets/big_text.dart';
import 'package:BandoBasta/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _dateController = TextEditingController();
  final _numberOfGuestsController = TextEditingController();
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
    'Bratabanda',
    'Other'
  ];

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
          elevation: 0,
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: Dimensions.height20),
                  child: BigText(
                    text: "Thinking of booking a venue?",
                    size: Dimensions.font15 + 2,
                    color: AppColors.mainBlackColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                _buildCheckAvailability(),
                SizedBox(
                  height: Dimensions.height10,
                ),
                BigText(text: "Featured Services"),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Container(
                  height: Dimensions.height20 * 4.4,
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    childAspectRatio: 1.0,
                    mainAxisSpacing: Dimensions.height10,
                    crossAxisSpacing: Dimensions.width20,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getSearchVenue());
                        },
                        child: serviceItem(Icons.location_city, "Venue"),
                      ),
                      serviceItem(Icons.camera_alt, "Photographer"),
                      serviceItem(Icons.person, "Priest"),
                      serviceItem(Icons.face, "Bridal Makeup"),
                      // serviceItem(Icons.music_note, "DJ Service"),
                      // serviceItem(Icons.brush, "Henna Artist"),
                      // serviceItem(Icons.card_giftcard, "Decoration"),
                      // serviceItem(Icons.diamond, "Jewellery"),
                    ],
                  ),
                ),
                _buildSectionHeader('Featured Venues'),
                HomePageBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckAvailability() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      padding: EdgeInsets.all(Dimensions.height10 * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Dimensions.height10 * 6,
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelStyle: TextStyle(color: AppColors.mainBlackColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                  borderSide: BorderSide(color: AppColors.mainBlackColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                  borderSide:
                      BorderSide(color: AppColors.mainBlackColor, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                  borderSide:
                      BorderSide(color: AppColors.mainBlackColor, width: 1.5),
                ),
              ),
              hint: Text('Select Event Type'),
              items:
                  eventTypes.map<DropdownMenuItem<String>>((String eventType) {
                return DropdownMenuItem<String>(
                  value: eventType,
                  child: Text(eventType),
                );
              }).toList(),
              value: _selectedEventType,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedEventType = newValue;
                });
              },
            ),
          ),
          SizedBox(height: Dimensions.height15),
          Row(
            children: [
              Flexible(
                child: AppTextField(
                  textEditingController: _dateController,
                  hintText: _isDateSelected
                      ? DateFormat.yMMMMd().format(_date)
                      : "Select Date",
                  icon: Icons.calendar_today_outlined,
                  readOnly: true,
                  width: double.infinity,
                  widget: IconButton(
                    onPressed: () => _getDate(),
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      color: AppColors.mainBlackColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: Dimensions.width10), // Spacing between the fields
              Flexible(
                child: AppTextField(
                  textEditingController: _numberOfGuestsController,
                  hintText: "Guests",
                  width: double.infinity,
                  icon: Icons.people,
                  readOnly: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.height15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_isValidInput()) {
                  AppConstant.eventType =
                      _transformEventType(_selectedEventType!);
                  AppConstant.selectedDate =
                      DateFormat('yyyy-MM-dd').format(_date);
                  AppConstant.numberOfGuests =
                      int.parse(_numberOfGuestsController.text);
                  AppConstant.isFeaturedVenueSelected = false;

                  Get.toNamed(RouteHelper.getSearchVenue());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            "Please select an event type, valid date, and number of guests")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.themeColor,
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.height10 * 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                ),
              ),
              child: BigText(
                text: 'Check Availability',
                color: Colors.white,
                size: Dimensions.font10 * 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isValidInput() {
    return _selectedEventType != null &&
        _isDateSelected &&
        _numberOfGuestsController.text.isNotEmpty &&
        int.tryParse(_numberOfGuestsController.text) != null &&
        int.parse(_numberOfGuestsController.text) > 0;
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
        _dateController.text = DateFormat.yMMMMd().format(_pickerDate);
      });
    }
  }

  bool _isValidNumberOfGuests() {
    if (_numberOfGuestsController.text.isEmpty) {
      return false;
    }
    guests = int.tryParse(_numberOfGuestsController.text);
    return guests != null && guests! > 0;
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
