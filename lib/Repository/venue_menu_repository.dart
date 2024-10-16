import 'package:get/get_connect.dart';

import '../utils/api/api_client.dart';
import '../utils/app_constants/app_constant.dart';

class VenueMenuRepo {
  final APIClient apiClient;

  VenueMenuRepo({required this.apiClient});

  Future<Response> getVenueMenus() async {
    return await apiClient.getData(
        AppConstant.getVenueMenusURI(), apiClient.mainHeaders);
  }
}
