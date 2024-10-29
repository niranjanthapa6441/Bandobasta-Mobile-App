import 'package:BandoBasta/Request/update_profile_request.dart';
import 'package:BandoBasta/utils/auth_service/auth_service.dart';
import 'package:get/get.dart';
import '../utils/api/api_client.dart';
import '../utils/app_constants/app_constant.dart';

class UserRepo extends GetxService {
  final APIClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> getUserDetails() async {
    AuthService authService = AuthService();
    return await apiClient.getData(
        AppConstant.getProfileURL(await authService.getUserId()));
  }

  Future<Response> updateUser(UpdateProfileRequest request) async {
  AuthService authService = AuthService();
    return await apiClient.putData(
        AppConstant.getUpdateProfileURL(await authService.getUserId()), request.toJson());
  }
}
