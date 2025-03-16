import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../utils/color/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _isDateSelected = false;
  DateTime _date = DateTime.now();
  int? guests;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(height: 40), // Space for status bar
              Row(
                children: [
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(
                      //side: BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(70),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 16,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              SizedBox(height: Dimensions.height20),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ),
                elevation: 5,
                shadowColor: Colors.black12,
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Hero(
                      tag: "searchBar",
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 2,
                              spreadRadius: 1,
                              blurStyle: BlurStyle.solid,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.black54),
                            SizedBox(width: 10),
                            Expanded(
                              child: Material(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Search Venues",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Suggested Venues",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          VenueTile(
                            title:
                                "Ghantaghar Party Palace & Restro, Bhaisipati",
                            subtitle: "For its top-notch dining",
                          ),
                          VenueTile(
                            title: "Unity Food & Banquet, Bhaisipati",
                            subtitle: "For its bustling Environemnt",
                          ),
                          VenueTile(
                            title:
                                "Ghantaghar Party Palace & Restro, Bhaisipati",
                            subtitle: "For its top-notch dining",
                          ),
                          VenueTile(
                            title: "Unity Food & Banquet, Bhaisipati",
                            subtitle: "For its bustling Environemnt",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ),
                elevation: 5,
                child: SizedBox(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("When"),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                _isDateSelected = true;
                                _getDate();
                              });
                            },
                            child: Text(_isDateSelected
                                ? DateFormat.yMMMMd().format(_date).toString()
                                : "Add Date")),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ),
                elevation: 5,
                child: SizedBox(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Who"),
                        //Spacer(),
                        Text("Add Guests"),
                      ],
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text('Clear All'),
                    ),
                    //const SizedBox(width: 10),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.4,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconsax.search_normal_1, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              "Search",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //onst SizedBox(width: 10),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class VenueTile extends StatelessWidget {
  final String title;
  final String subtitle;
  const VenueTile({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.location_on, color: Colors.blue),
      title: Text(title, style: TextStyle(fontSize: 16)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey)),
      onTap: () {},
    );
  }
}

_getDate() async {
  DateTime? pickerDate = await showDatePicker(
    context: Get.context!,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(9999),
    builder: (context, child) {
      return Theme(
        data: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: AppColors.themeColor, // Change the primary color here
          ),
        ),
        child: child!,
      );
    },
  );
}
