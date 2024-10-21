import 'package:bandobasta/Request/log_in_request.dart';
import 'package:bandobasta/Request/sign_up_request.dart';
import 'package:bandobasta/utils/api/api_client.dart';
import 'package:bandobasta/utils/app_constants/app_constant.dart';
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

  Future<void> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
  }
}
