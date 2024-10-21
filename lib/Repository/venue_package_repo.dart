import 'package:get/get_connect.dart';

import '../utils/api/api_client.dart';
import '../utils/app_constants/app_constant.dart';

class VenuePackageRepo {
  final APIClient apiClient;

  VenuePackageRepo({required this.apiClient});

  Future<Response> getVenuePackages() async {
    return await apiClient.getData(
        AppConstant.getVenuePackagesURI(), apiClient.mainHeaders);
  }
}
