import 'package:BandoBasta/Model/response_model.dart';
import 'package:BandoBasta/Repository/auth_repository.dart';
import 'package:BandoBasta/Request/log_in_request.dart';
import 'package:BandoBasta/Request/sign_up_request.dart';
import 'package:BandoBasta/Response/log_in_reponse.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:BandoBasta/utils/service/auth_service.dart';
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
    Response response = await authRepo.login(loginBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      details = LogInResponse.fromJson(response.body);
      responseModel = ResponseModel(true, response.body["message"]);
      authRepo.saveUserToken(details.data!.accessToken.toString());
      AuthService authService = new AuthService();
      authService.storeToken(details.data!.accessToken.toString());
      AppConstant.saveUserId(details.data!.id.toString());
      print(AppConstant.userId.toString() + "userID");
    } else {
      responseModel = ResponseModel(false, response.body["message"]);
    }
    update();
    return responseModel;
  }
}
