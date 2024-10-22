import 'package:bandobasta/Request/update_profile_request.dart';
import 'package:get/get.dart';
import '../utils/api/api_client.dart';
import '../utils/app_constants/app_constant.dart';

class UserRepo extends GetxService {
  final APIClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> getUserDetails() async {
    return await apiClient.getData(
        AppConstant.getProfileURL(),
        apiClient.mainHeaders);
  }

  Future<Response> updateUser(UpdateProfileRequest request) async {
    return await apiClient.putData(
        AppConstant.getUpdateProfileURL(), request.toJson());
  }
}
