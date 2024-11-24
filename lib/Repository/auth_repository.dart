import 'package:BandoBasta/Request/forgot_password_request.dart';
import 'package:BandoBasta/Request/log_in_request.dart';
import 'package:BandoBasta/Request/reset_password_request.dart';
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

  Future<Response> sendOTPEmail(ForgotPasswordRequest request) async {
    return await apiClient.postData(
        AppConstant.getSendOTPEmailURL(), request.toJson());
  }

  Future<Response> verifyOTP(otp, Object request) async {
    return await apiClient.postData(AppConstant.getVerifyOTPURL(otp), request);
  }

  Future<Response> resetPassword(ResetPasswordRequest resetPassword) async {
    return await apiClient.postData(
        AppConstant.getResetPasswordURL(), resetPassword.toJson());
  }
  
  Future<Response> verifyRegisteredAccount(String token) async {
    return await apiClient.getData(
        AppConstant.getVerifyAccountURL(token));
  }
}
