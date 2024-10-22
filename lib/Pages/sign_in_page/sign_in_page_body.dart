import 'package:BandoBasta/Request/log_in_request.dart';
import 'package:BandoBasta/controller/auth_controller.dart';
import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:BandoBasta/widgets/app_text_field.dart';
import 'package:BandoBasta/widgets/big_text.dart';
import 'package:BandoBasta/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPageBody extends StatefulWidget {
  const SignInPageBody({Key? key}) : super(key: key);

  @override
  State<SignInPageBody> createState() => _SignInPageBodyState();
}

class _SignInPageBodyState extends State<SignInPageBody> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
      child: ListView(
        children: [
          Column(children: [
            Container(
              height: Dimensions.height20 * 6,
            ),
            PreferredSize(
              preferredSize: Size.fromHeight(Dimensions.height20 * 3.5),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Container(
                        height: Dimensions.height10 * 8,
                        width: Dimensions.height10 * 8,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/wedding.png"),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.width5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: "BandoBasta",
                          color: AppColors.themeColor,
                          size: Dimensions.font20 * 1.2,
                          fontWeight: FontWeight.w900,
                        ),
                        SmallText(
                          text: "Effortless booking",
                          color: AppColors.themeColor,
                          size: Dimensions.font10 * 1.5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: Dimensions.height20 * 2,
            ),
            Container(
              margin: EdgeInsets.only(left: Dimensions.width30),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: Dimensions.font30 * 2,
                      fontWeight: FontWeight.w600,
                      color: AppColors.themeColor,
                    ),
                  ),
                  Text(
                    "Sign In to your account",
                    style: TextStyle(
                      fontSize: Dimensions.font10 * 2,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[400],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(
              textEditingController: usernameController,
              hintText: "Username",
              icon: Icons.person,
              width: Dimensions.width10 * 37,
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(
              textEditingController: passwordController,
              hintText: "Password",
              icon: Icons.password,
              isObscure: true,
              width: Dimensions.width10 * 37,
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
          ]),
          SizedBox(
            height: Dimensions.height30,
          ),
          GestureDetector(
            onTap: () {
              _loginValidation();
            },
            child: Container(
              margin: EdgeInsets.only(
                left: Dimensions.width30 +
                    Dimensions.width30 +
                    Dimensions.width30 +
                    Dimensions.width30,
                right: Dimensions.width30 +
                    Dimensions.width30 +
                    Dimensions.width30 +
                    Dimensions.width30,
              ),
              height: Dimensions.screenHeight / 13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: AppColors.themeColor,
              ),
              child: Center(
                child: BigText(
                  text: "Sign In",
                  size: Dimensions.font30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: Dimensions.height10,
          ),
          GestureDetector(
            onTap: () => Get.toNamed(RouteHelper.getSignUp()),
            child: Container(
              height: 30,
              margin: EdgeInsets.only(bottom: Dimensions.height30),
              child: Center(
                child: RichText(
                  text: TextSpan(
                      text: "Don't Have an Account? ",
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: Dimensions.font10 * 1.6,
                      ),
                      children: [
                        TextSpan(
                          text: "Create",
                          style: TextStyle(
                            color: AppColors.themeColor,
                            fontSize: Dimensions.font10 * 1.8,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ]),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _loginValidation() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    if (username.isEmpty) {
      showCustomSnackBar("Username is Empty", title: "Username");
    } else if (password.isEmpty) {
      showCustomSnackBar("Password is Empty", title: "Password");
    } else {
      LogInRequest userCredentials =
          LogInRequest(username: username, password: password);
      var authController = Get.find<AuthController>();
      authController.login(userCredentials).then((status) {
        if (status.isSuccess) {
          Get.toNamed(RouteHelper.getNavigation());
          AppConstant.isUserLoggedIn = true;
        } else {
          showCustomSnackBar(status.message, title: "Invalied Login details");
        }
      });
    }
  }

  void showCustomSnackBar(String message,
      {bool isError = true, String title = "Error", Color color = Colors.red}) {
    Get.snackbar(title, message,
        titleText: BigText(
          text: title,
          color: Colors.white,
        ),
        messageText: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        backgroundColor: color);
  }
}
