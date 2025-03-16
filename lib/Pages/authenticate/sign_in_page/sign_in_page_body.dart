import 'package:BandoBasta/Request/log_in_request.dart';
import 'package:BandoBasta/Controller/auth_controller.dart';
import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:BandoBasta/widgets/app_text_field.dart';
import 'package:BandoBasta/widgets/big_text.dart';
import 'package:BandoBasta/widgets/error_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPageBody extends StatefulWidget {
  const SignInPageBody({super.key});

  @override
  State<SignInPageBody> createState() => _SignInPageBodyState();
}

class _SignInPageBodyState extends State<SignInPageBody> {
  String usernameError = '';
  String passwordError = '';

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main content
        Container(
          margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(height: Dimensions.height20 * 6),
                  SizedBox(
                    height: Dimensions.height10 * 10,
                    child: Center(
                      child: Container(
                        height: Dimensions.height10 * 10,
                        width: Dimensions.height10 * 20,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage("assets/images/logo.png"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.height20),
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.height20),
                  AppTextField(
                    textEditingController: usernameController,
                    hintText: "Username",
                    icon: Icons.person,
                    width: Dimensions.width10 * 37,
                  ),
                  ErrorLabel(
                    error: usernameError,
                  ),
                  AppTextField(
                    textEditingController: passwordController,
                    hintText: "Password",
                    icon: _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    isObscure: !_isPasswordVisible, // Toggle visibility
                    width: Dimensions.width10 * 37,
                    onIconPressed: () {
                      setState(() {
                        _isPasswordVisible =
                            !_isPasswordVisible; // Toggle state
                      });
                    },
                  ),
                  ErrorLabel(
                    error: passwordError,
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height30),
              GestureDetector(
                onTap: _isLoading ? null : _submitForm,
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: Dimensions.width30 * 4),
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
              SizedBox(height: Dimensions.height10),
              GestureDetector(
                onTap: () => Get.toNamed(RouteHelper.getSignUp()),
                child: SizedBox(
                  height: Dimensions.height10 * 3,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10),
              GestureDetector(
                onTap: () => Get.toNamed(RouteHelper.getEmailOTP()),
                child: SizedBox(
                  height: Dimensions.height10 * 3,
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Forgot Password!! ",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: Dimensions.font10 * 1.6,
                        ),
                        children: [
                          TextSpan(
                            text: "Reset",
                            style: TextStyle(
                              color: AppColors.themeColor,
                              fontSize: Dimensions.font10 * 1.8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_isLoading)
          Center(
            child: CircularProgressIndicator(
              color: AppColors.themeColor,
            ),
          ),
      ],
    );
  }

  void _submitForm() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    setState(() {
      usernameError = '';
      passwordError = '';
    });

    if (username.isEmpty || password.isEmpty) {
      if (username.isEmpty) {
        setState(() {
          usernameError = "Username is required";
        });
      }
      if (password.isEmpty) {
        setState(() {
          passwordError = "Password is required";
        });
      }
      return; // Exit early if there are errors
    }

    setState(() {
      _isLoading = true; // Start loading
    });

    LogInRequest userCredentials =
        LogInRequest(username: username, password: password);
    var authController = Get.find<AuthController>();

    authController.login(userCredentials).then((status) {
      setState(() {
        _isLoading = false; // Stop loading
      });

      if (status.isSuccess) {
        Get.toNamed(RouteHelper.getNavigation());
      } else {
        showCustomSnackBar(status.message, title: "Invalid Login Details");
      }
    }).catchError((error) {
      setState(() {
        _isLoading = false; // Stop loading
      });
      showCustomSnackBar("An error occurred. Please try again.",
          title: "Error");
    });
  }

  void showCustomSnackBar(String message,
      {bool isError = true, String title = "Error", Color color = Colors.red}) {
    Get.snackbar(
      title,
      message,
      titleText: BigText(text: title, color: Colors.white),
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      backgroundColor: color,
    );
  }
}
