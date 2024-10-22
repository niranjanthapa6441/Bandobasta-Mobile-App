import 'package:bandobasta/Model/response_model.dart';
import 'package:bandobasta/Repository/auth_repository.dart';
import 'package:bandobasta/Request/log_in_request.dart';
import 'package:bandobasta/Request/sign_up_request.dart';
import 'package:bandobasta/Response/log_in_reponse.dart';
import 'package:bandobasta/utils/app_constants/app_constant.dart';
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
    print(response.body);
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
    _isLoading = true;
    Response response = await authRepo.login(loginBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      details = LogInResponse.fromJson(response.body);
      responseModel = ResponseModel(true, response.body["message"]);
      authRepo.saveUserToken(details.data!.accessToken.toString());
      print("access token:"+ details.data!.accessToken.toString());
      AppConstant.userId = details.data!.id.toString();
    } else {
      responseModel = ResponseModel(false, response.body["message"]);
    }
    update();
    return responseModel;
  }
}
