
import 'package:bandobasta/utils/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../app_constants/app_constant.dart';

Future<void> init() async {
  final sharedPreferences = SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  Get.lazyPut(() => APIClient(appBaseUrl: AppConstant.baseURL));

  //repos
  // Get.lazyPut(() => AuthRepo(apiClient: Get.find()));

  //controller
  // Get.lazyPut(() => AuthController(authRepo: Get.find()));

}
