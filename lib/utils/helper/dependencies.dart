
import 'package:bandobasta/Controller/venueController.dart';
import 'package:bandobasta/Repository/venueRepo.dart';
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

  //controller
  Get.lazyPut(() => VenueController(venueRepo: Get.find()));

}
