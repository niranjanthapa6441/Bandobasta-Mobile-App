import 'package:BandoBasta/Controller/booking_controller.dart';
import 'package:BandoBasta/Controller/check_hall_availability_controller.dart';
import 'package:BandoBasta/Controller/user_controller.dart';
import 'package:BandoBasta/Controller/venue_controller.dart';
import 'package:BandoBasta/Controller/venue_hall_controller.dart';
import 'package:BandoBasta/Controller/venue_menu_controller.dart';
import 'package:BandoBasta/Controller/venue_package_controller.dart';
import 'package:BandoBasta/Repository/auth_repository.dart';
import 'package:BandoBasta/Repository/hall_availability_repo.dart';
import 'package:BandoBasta/Repository/booking_repository.dart';
import 'package:BandoBasta/Repository/venue_hall_repo.dart';
import 'package:BandoBasta/Repository/venue_menu_repository.dart';
import 'package:BandoBasta/Repository/venue_package_repo.dart';
import 'package:BandoBasta/Repository/venue_repo.dart';
import 'package:BandoBasta/controller/auth_controller.dart';
import 'package:BandoBasta/repository/customer_repo.dart';
import 'package:BandoBasta/utils/api/api_client.dart';
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
  Get.lazyPut(() => VenuePackageRepo(apiClient: Get.find()));
  Get.lazyPut(() => HallAvailabilityRepo(apiClient: Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  //controller
  Get.lazyPut(() => VenueController(venueRepo: Get.find()));
  Get.lazyPut(() => BookingController(bookingRepository: Get.find()));
  Get.lazyPut(() => VenueMenuController(venueMenuRepo: Get.find()));
  Get.lazyPut(() => VenueHallController(venueHallRepo: Get.find()));
  Get.lazyPut(() => VenuePackageController(venuePackageRepo: Get.find()));
  Get.lazyPut(
      () => HallAvailabilityController(hallAvailabilityRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
}
