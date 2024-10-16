import 'package:get/get_connect.dart';

import '../utils/api/api_client.dart';
import '../utils/app_constants/app_constant.dart';

class VenueRepo {
  final APIClient apiClient;

  VenueRepo({required this.apiClient});

  Future<Response> getVenues() async {
    return await apiClient.getData(
        AppConstant.getVenueURI(), apiClient.mainHeaders);
  }
}