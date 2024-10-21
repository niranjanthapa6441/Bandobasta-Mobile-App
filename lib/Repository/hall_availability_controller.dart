import 'package:get/get_connect.dart';

import '../utils/api/api_client.dart';
import '../utils/app_constants/app_constant.dart';

class HallAvailabilityRepo {
  final APIClient apiClient;

  HallAvailabilityRepo({required this.apiClient});

  Future<Response> getHallAvailabilities() async {
    return await apiClient.getData(
        AppConstant.getHallAvailabilitiesURL(), apiClient.mainHeaders);
  }
}
