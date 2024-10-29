import 'package:BandoBasta/Request/log_in_request.dart';
import 'package:BandoBasta/Request/sign_up_request.dart';
import 'package:BandoBasta/utils/api/api_client.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:get/get.dart';

class AuthRepo {
  final APIClient apiClient;

  AuthRepo({required this.apiClient});

  Future<Response> registration(SignUpRequest signUpBody) async {
    return await apiClient.postData(
        AppConstant.getSignUpURL(), signUpBody.toJson());
  }

  Future<Response> login(LogInRequest loginBody) async {
    return await apiClient.postData(
        AppConstant.getSignInURL(), loginBody.toJson());
  }
}
