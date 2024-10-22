import 'package:BandoBasta/Controller/venue_controller.dart';
import 'package:BandoBasta/Response/venue_response.dart';
import 'package:BandoBasta/card/venue_card.dart';
import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:BandoBasta/widgets/app_button.dart';
import 'package:BandoBasta/widgets/big_text.dart';
import 'package:BandoBasta/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class SearchVenuePage extends StatefulWidget {
  @override
  _SearchVenuePageState createState() => _SearchVenuePageState();
}

class _SearchVenuePageState extends State<SearchVenuePage> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Get.find<VenueController>().onClose();
    Get.find<VenueController>().get();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _clear();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Get.find<VenueController>().loadMore();
    }
  }

  String selectedLocation = '--Select Location--';
  double minPrice = 0;
  double maxPrice = 10000;
  int selectedCapacity = 0;
  int minCapacity = 0;
  int maxCapacity = 10000;

  var searchCriteria = TextEditingController();
  bool isSearching = false;

  void _showFilterDialog() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.85,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cancel Icon Button
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.cancel, color: AppColors.themeColor),
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                      ),
                    ),
                    Text('Filter',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    // Location filter
                    Text('Location'),
                    DropdownButton<String>(
                      value: selectedLocation,
                      isExpanded: true,
                      items: [
                        '--Select Location--',
                        'Kathmandu',
                        'Pokhara',
                        'Bhaktapur',
                        'Lalitpur',
                        'Nepalgunj',
                        'Biratnagar',
                        'Janakpur'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedLocation = value!;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    // Price range filter
                    Text('Price Range'),
                    RangeSlider(
                      values: RangeValues(minPrice, maxPrice),
                      min: 0,
                      max: 10000,
                      activeColor: AppColors.themeColor,
                      divisions: 20,
                      onChanged: (RangeValues values) {
                        setState(() {
                          minPrice = values.start;
                          maxPrice = values.end;
                        });
                      },
                    ),
                    Text(
                        "Min: ${minPrice.toInt()} NPR - Max: ${maxPrice.toInt()} NPR"),
                    SizedBox(height: 20),
                    // Capacity filter
                    Text('Capacity'),
                    Column(
                      children: <Widget>[
                        RadioListTile(
                          title: const Text('Up to 100'),
                          value: 0,
                          activeColor: AppColors.themeColor,
                          groupValue: selectedCapacity,
                          onChanged: (int? value) {
                            setState(() {
                              selectedCapacity = value!;
                              minCapacity = 0;
                              maxCapacity = 100;
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text('100-300'),
                          value: 1,
                          activeColor: AppColors.themeColor,
                          groupValue: selectedCapacity,
                          onChanged: (int? value) {
                            setState(() {
                              selectedCapacity = value!;
                              minCapacity = 101;
                              maxCapacity = 300;
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text('300-500'),
                          value: 2,
                          activeColor: AppColors.themeColor,
                          groupValue: selectedCapacity,
                          onChanged: (int? value) {
                            setState(() {
                              selectedCapacity = value!;
                              minCapacity = 301;
                              maxCapacity = 500;
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text('500+'),
                          value: 3,
                          activeColor: AppColors.themeColor,
                          groupValue: selectedCapacity,
                          onChanged: (int? value) {
                            setState(() {
                              selectedCapacity = value!;
                              minCapacity = 501;
                              maxCapacity = 10000;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Center the AppButton
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          _applyFilter();

                          Navigator.pop(context);
                        },
                        child: AppButton(
                          btn_txt: 'Apply',
                          buttonHeight: Dimensions.height50,
                          buttonWidth: Dimensions.width30 * 5,
                          color: AppColors.themeColor,
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.height10 * 2),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Dimensions.height20 * 3.5),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.themeColor,
            ),
            onPressed: () {
              dispose();
              Get.toNamed(RouteHelper.getNavigation());
            },
          ),
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Container(
                    height: Dimensions.height10 * 5,
                    width: Dimensions.height10 * 5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/wedding.png"),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.width5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: "BandoBasta",
                      color: AppColors.themeColor,
                      size: Dimensions.font20,
                      fontWeight: FontWeight.w900,
                    ),
                    SmallText(
                      text: "Effortless booking",
                      color: AppColors.themeColor,
                      size: Dimensions.font12,
                    ),
                  ],
                ),
              ],
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    blurRadius: 8,
                    spreadRadius: 6,
                    offset: const Offset(1, 8),
                    color: Colors.grey.withOpacity(0.2))
              ]),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        isSearching = true;
                        _applyFilter();
                      },
                      readOnly: false,
                      obscureText: false,
                      controller: searchCriteria,
                      decoration: InputDecoration(
                        hintText: "Search For Venues",
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.themeColor,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius30),
                          borderSide:
                              BorderSide(width: 1.0, color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius30),
                          borderSide:
                              BorderSide(width: 1.0, color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.height20),
            // Venue cards section
            Expanded(
              child: GetBuilder<VenueController>(builder: (controller) {
                return GestureDetector(
                  child: controller.isLoaded
                      ? Container(
                          height: Dimensions.height10 * 55,
                          padding: EdgeInsets.only(bottom: Dimensions.height20),
                          child: ListView.builder(
                            controller: _scrollController,
                            padding: EdgeInsets.zero,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: controller.venues.length + 1,
                            itemBuilder: (context, index) {
                              if (index != controller.totalElements &&
                                  index == controller.venues.length) {
                                return _buildSingleLoadingIndicator();
                              } else if (index == controller.totalElements &&
                                  index == controller.venues.length) {
                                return Container();
                              }
                              return _buildVenueCard(
                                  controller.venues[index], index);
                            },
                          ),
                        )
                      : _buildLoadingIndicator(),
                );
              }),
            ),
          ],
        ),
      ),
      // Floating Action Button for filter
      floatingActionButton: FloatingActionButton(
        onPressed: _showFilterDialog,
        backgroundColor: AppColors.themeColor,
        child: Icon(
          FontAwesomeIcons.slidersH,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  String? getImagePath(List<String>? venueImagePaths) {
    if (venueImagePaths != null && venueImagePaths.isNotEmpty) {
      return venueImagePaths[0];
    }
    return null;
  }

  Widget _buildVenueCard(Venue venue, int index) {
    return VenueCard(
        imageUrl: AppConstant.baseURL +
            AppConstant.apiVersion +
            getImagePath(venue.venueImagePaths)!,
        name: venue.name!,
        rating: "4.0",
        reviews: "Very good",
        location: venue.address!,
        price: "NPR " + venue.startingPrice! + " onwards",
        onViewInfo: () {
          Get.toNamed(RouteHelper.getVenueInfo(index));
          clearFilters();
          AppConstant.venueName = venue.name!;
          AppConstant.venueImageURL = getImagePath(venue.venueImagePaths!)!;
        });
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
          itemCount: 5,
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

  void _applyFilter() {
    AppConstant.venueName = searchCriteria.text.toString();
    if (selectedLocation == '--Select Location--') {
      AppConstant.address = '';
    } else {
      AppConstant.address = selectedLocation;
    }
    AppConstant.maxCapacity = maxCapacity;
    AppConstant.minCapacity = minCapacity;
    AppConstant.minPrice = minPrice;
    AppConstant.maxPrice = maxPrice;

    Get.find<VenueController>().onClose();
    Get.find<VenueController>().get();
  }

  void _clear() {
    AppConstant.venueName = '';
    AppConstant.minCapacity = 0;

    AppConstant.maxCapacity = 10000;

    AppConstant.minPrice = 0.0;

    AppConstant.maxPrice = 10000.0;
    AppConstant.address = '';

    AppConstant.page = 1;

    Get.find<VenueController>().onClose();
    Get.find<VenueController>().get();
  }

  void clearFilters() {
    selectedLocation = "--Select Location--";
    minPrice = 0;
    maxPrice = 10000;
    selectedCapacity = 0;
    minCapacity = 0;
    maxCapacity = 10000;
    AppConstant.venueName = '';
    AppConstant.minCapacity = 0;

    AppConstant.maxCapacity = 10000;

    AppConstant.minPrice = 0.0;

    AppConstant.maxPrice = 10000.0;
    AppConstant.address = '';

    AppConstant.page = 1;
    searchCriteria.clear();
  }
}
