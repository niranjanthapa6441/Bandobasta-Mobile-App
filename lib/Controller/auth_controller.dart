import 'package:BandoBasta/Model/response_model.dart';
import 'package:BandoBasta/Repository/auth_repository.dart';
import 'package:BandoBasta/Request/forgot_password_request.dart';
import 'package:BandoBasta/Request/log_in_request.dart';
import 'package:BandoBasta/Request/reset_password_request.dart';
import 'package:BandoBasta/Request/sign_up_request.dart';
import 'package:BandoBasta/Response/log_in_reponse.dart';
import 'package:BandoBasta/utils/api/api_client.dart';
import 'package:BandoBasta/utils/auth_service/auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  late LogInResponse details;
  Future<ResponseModel> registration(SignUpRequest signUpBody) async {
    _isLoading = true;
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.body["message"]);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> login(LogInRequest loginBody) async {
    AuthService _authService = AuthService();
    Response response = await authRepo.login(loginBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      details = LogInResponse.fromJson(response.body);
      responseModel = ResponseModel(true, response.body["message"]);
      _authService.storeToken(details.data!.accessToken.toString());
      _authService.storeUserId(details.data!.id.toString());
      String? token = await _authService.getToken();
      APIClient apiClient = Get.find<APIClient>();
      await apiClient.initializeTokenAndHeaders();
    } else {
      responseModel = ResponseModel(false, response.body["message"]);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> sendOTPEmail(ForgotPasswordRequest request) async {
    Response response = await authRepo.sendOTPEmail(request);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.body["message"]);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> verifyOTP(String otp) async {
    Response response = await authRepo.verifyOTP(otp, {});
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.body["message"]);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> resetPassword(
      ResetPasswordRequest resetPassword) async {
    Response response = await authRepo.resetPassword(resetPassword);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      print(response.body["message"]);
      print(response.body["errorData"]);
      responseModel = ResponseModel(false, response.body["message"]);
    }
    update();
    return responseModel;
  }
}
