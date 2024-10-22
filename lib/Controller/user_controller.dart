import 'package:bandobasta/Model/response_model.dart';
import 'package:bandobasta/Request/update_profile_request.dart';
import 'package:bandobasta/Response/user_profile_response.dart';
import 'package:bandobasta/repository/customer_repo.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final UserRepo userRepo;

  UserController({required this.userRepo});
  User? user;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> getCustomerDetails() async {
    Response response = await userRepo.getUserDetails();
    print(response.body);
    if (response.statusCode == 200) {
      _isLoaded = true;
      user = UserProfileResponse.fromJson(response.body).data;
      update();
    } else {
      print(response.body["message"]);
    }
  }

  Future<ResponseModel> updateProfile(UpdateProfileRequest request) async {
    Response response = await userRepo.updateUser(request);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.body["message"]);
    }
    update();
    return responseModel;
  }
}
