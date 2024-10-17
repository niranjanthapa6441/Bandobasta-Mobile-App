import 'package:get/get_connect.dart';

import '../utils/api/api_client.dart';
import '../utils/app_constants/app_constant.dart';

class VenueHallRepo {
  final APIClient apiClient;

  VenueHallRepo({required this.apiClient});

  Future<Response> getVenueHalls() async {
    return await apiClient.getData(
        AppConstant.getVenueHallsURI(), apiClient.mainHeaders);
  }
}
