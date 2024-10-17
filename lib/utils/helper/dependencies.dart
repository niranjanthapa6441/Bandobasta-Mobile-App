import 'package:bandobasta/Controller/booking_controller.dart';
import 'package:bandobasta/Controller/venue_controller.dart';
import 'package:bandobasta/Controller/venue_hall_controller.dart';
import 'package:bandobasta/Controller/venue_menu_controller.dart';
import 'package:bandobasta/Repository/order_repository.dart';
import 'package:bandobasta/Repository/venue_hall_repo.dart';
import 'package:bandobasta/Repository/venue_menu_repository.dart';
import 'package:bandobasta/Repository/venu_repo.dart';
import 'package:bandobasta/utils/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../app_constants/app_constant.dart';

Future<void> init() async {
  final sharedPreferences = SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  Get.lazyPut(() => APIClient(appBaseUrl: AppConstant.baseURL));

  //repos
  Get.lazyPut(() => VenueRepo(apiClient: Get.find()));
  Get.lazyPut(() => BookingRepository(apiClient: Get.find()));
  Get.lazyPut(() => VenueMenuRepo(apiClient: Get.find()));
  Get.lazyPut(() => VenueHallRepo(apiClient: Get.find()));

  //controller
  Get.lazyPut(() => VenueController(venueRepo: Get.find()));
  Get.lazyPut(() => BookingController(bookingRepository: Get.find()));
  Get.lazyPut(() => VenueMenuController(venueMenuRepo: Get.find()));
  Get.lazyPut(() => VenueHallController(venueHallRepo: Get.find()));
}
