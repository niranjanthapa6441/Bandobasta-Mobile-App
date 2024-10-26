import 'dart:async';

import 'package:BandoBasta/Controller/venue_controller.dart';
import 'package:BandoBasta/Response/venue_response.dart';
import 'package:BandoBasta/card/venue_card.dart';
import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:BandoBasta/widgets/app_button.dart';
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
  Timer? _debounce;
  var searchCriteria = TextEditingController();
  bool isSearching = false;

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        isSearching = true;
      });
      _applyFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(),
            SizedBox(height: Dimensions.height20),
            Expanded(child: _buildVenueCards()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showFilterDialog,
        backgroundColor: AppColors.themeColor,
        child: Icon(FontAwesomeIcons.slidersH, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: Dimensions.height10 * 8,
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.themeColor),
        onPressed: () {
          dispose();
          Get.toNamed(RouteHelper.getNavigation());
        },
      ),
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
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            spreadRadius: 6,
            offset: Offset(1, 8),
            color: Colors.grey.withOpacity(0.2),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              onChanged: _onSearchChanged,
              controller: searchCriteria,
              decoration: InputDecoration(
                hintText: "Search For Venues",
                prefixIcon: Icon(Icons.search, color: AppColors.themeColor),
                focusedBorder: _buildInputBorder(),
                enabledBorder: _buildInputBorder(),
                border: _buildInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _buildInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(Dimensions.radius30),
      borderSide: BorderSide(width: 1.0, color: Colors.white),
    );
  }

  Widget _buildVenueCards() {
    return GetBuilder<VenueController>(builder: (controller) {
      return controller.isLoaded
          ? controller.venues.isEmpty
              ? Center(
                  child: Text("Venue Not Found"),
                )
              : Container(
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
                      return _buildVenueCard(controller.venues[index], index);
                    },
                  ),
                )
          : _buildLoadingIndicator();
    });
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.85,
        child: StatefulBuilder(
          builder: (context, setState) => SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFilterDialogHeader(setState),
                _buildLocationDropdown(setState),
                _buildPriceRangeSlider(setState),
                _buildCapacityOptions(setState),
                _buildApplyButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterDialogHeader(StateSetter setState) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        icon: Icon(Icons.cancel, color: AppColors.themeColor),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildLocationDropdown(StateSetter setState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            return DropdownMenuItem(value: value, child: Text(value));
          }).toList(),
          onChanged: (value) => setState(() => selectedLocation = value!),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPriceRangeSlider(StateSetter setState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Price Range'),
        RangeSlider(
          values: RangeValues(minPrice, maxPrice),
          min: 0,
          max: 10000,
          divisions: 20,
          activeColor: AppColors.themeColor,
          onChanged: (values) => setState(() {
            minPrice = values.start;
            maxPrice = values.end;
          }),
        ),
        Text("Min: ${minPrice.toInt()} NPR - Max: ${maxPrice.toInt()} NPR"),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCapacityOptions(StateSetter setState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Capacity'),
        _buildRadioListTile('Up to 100', 0, 0, 100, setState),
        _buildRadioListTile('100-300', 1, 101, 300, setState),
        _buildRadioListTile('300-500', 2, 301, 500, setState),
        _buildRadioListTile('500+', 3, 501, 10000, setState),
      ],
    );
  }

  RadioListTile<int> _buildRadioListTile(
      String title, int value, int minCap, int maxCap, StateSetter setState) {
    return RadioListTile(
      title: Text(title),
      value: value,
      groupValue: selectedCapacity,
      activeColor: AppColors.themeColor,
      onChanged: (int? val) => setState(() {
        selectedCapacity = val!;
        minCapacity = minCap;
        maxCapacity = maxCap;
      }),
    );
  }

  Widget _buildApplyButton() {
    return Center(
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
    );
  }

  void _applyFilter() {
    var venueController = Get.find<VenueController>();
    venueController.onClose();
    AppConstant.venueName = searchCriteria.text.toString();
    AppConstant.address =
        selectedLocation == '--Select Location--' ? '' : selectedLocation;
    AppConstant.maxCapacity = maxCapacity;
    AppConstant.minCapacity = minCapacity;
    AppConstant.minPrice = minPrice;
    AppConstant.maxPrice = maxPrice;
    venueController.get();
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

  void _clear() {
    AppConstant.venueName = '';
    AppConstant.minCapacity = 0;

    AppConstant.maxCapacity = 0;

    AppConstant.minPrice = 0.0;

    AppConstant.maxPrice = 0;
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

    AppConstant.maxCapacity = 0;

    AppConstant.minPrice = 0.0;

    AppConstant.maxPrice = 0.0;
    AppConstant.address = '';

    AppConstant.page = 1;
    AppConstant.size = 5;
    searchCriteria.clear();
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
}
