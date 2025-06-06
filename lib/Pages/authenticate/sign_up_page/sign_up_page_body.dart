import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching URLs
import 'package:BandoBasta/Request/sign_up_request.dart';
import 'package:BandoBasta/controller/auth_controller.dart';
import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:BandoBasta/widgets/app_text_field.dart';
import 'package:BandoBasta/widgets/big_text.dart';
import 'package:BandoBasta/widgets/error_label.dart';

class SignUpPageBody extends StatefulWidget {
  const SignUpPageBody({Key? key}) : super(key: key);

  @override
  State<SignUpPageBody> createState() => _SignUpPageBodyState();
}

class _SignUpPageBodyState extends State<SignUpPageBody> {
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isTermsAccepted = false; // For the checkbox

  var emailController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var middleNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  String firstNameError = '';
  String lastNameError = '';
  String middleNameError = '';
  String usernameError = '';
  String passwordError = '';
  String confirmPasswordError = '';
  String emailError = '';
  String phoneNumberError = '';
  String termsError = ''; // For displaying terms error

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: EdgeInsets.only(
            left: Dimensions.width10, right: Dimensions.width10),
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  height: Dimensions.height10 * 3,
                ),
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(height: Dimensions.height20),
                  AppTextField(
                      textEditingController: firstNameController,
                      hintText: "First Name",
                      width: Dimensions.width10 * 37,
                      color:
                          firstNameError.isEmpty ? null : AppColors.themeColor,
                      icon: Icons.person),
                  ErrorLabel(error: firstNameError),
                  AppTextField(
                      textEditingController: middleNameController,
                      hintText: "Middle Name",
                      icon: Icons.person,
                      width: Dimensions.width10 * 37),
                  SizedBox(height: Dimensions.height20),
                  AppTextField(
                      textEditingController: lastNameController,
                      hintText: "Last Name",
                      color:
                          lastNameError.isEmpty ? null : AppColors.themeColor,
                      icon: Icons.person,
                      width: Dimensions.width10 * 37),
                  ErrorLabel(error: lastNameError),
                  AppTextField(
                      textEditingController: usernameController,
                      hintText: "Username",
                      color:
                          usernameError.isEmpty ? null : AppColors.themeColor,
                      icon: Icons.person,
                      width: Dimensions.width10 * 37),
                  ErrorLabel(error: usernameError),
                  AppTextField(
                    textEditingController: passwordController,
                    hintText: "Password",
                    color: passwordError.isEmpty ? null : AppColors.themeColor,
                    icon: _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    isObscure: !_isPasswordVisible,
                    width: Dimensions.width10 * 37,
                    onIconPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  ErrorLabel(error: passwordError),
                  AppTextField(
                    textEditingController: confirmPasswordController,
                    hintText: "Confirm Password",
                    color: confirmPasswordError.isEmpty
                        ? null
                        : AppColors.themeColor,
                    icon: _isConfirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    isObscure: !_isConfirmPasswordVisible,
                    width: Dimensions.width10 * 37,
                    onIconPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                  ErrorLabel(error: confirmPasswordError),
                  AppTextField(
                    textEditingController: emailController,
                    hintText: "Email",
                    width: Dimensions.width10 * 37,
                    icon: Icons.email,
                    color: emailError.isEmpty ? null : AppColors.themeColor,
                  ),
                  ErrorLabel(error: emailError),
                  AppTextField(
                      textEditingController: phoneNumberController,
                      hintText: "Phone Number",
                      width: Dimensions.width10 * 37,
                      color: phoneNumberError.isEmpty
                          ? null
                          : AppColors.themeColor,
                      icon: Icons.phone),
                  ErrorLabel(error: phoneNumberError),
                  SizedBox(height: Dimensions.height20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: _isTermsAccepted,
                        onChanged: (bool? value) {
                          setState(() {
                            _isTermsAccepted = value ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: "I agree to the ",
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 16),
                            children: [
                              TextSpan(
                                text: "Privacy Policy",
                                style: TextStyle(
                                  color: AppColors.themeColor,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    _launchPrivacyPolicy();
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (termsError.isNotEmpty) ErrorLabel(error: termsError),
                ]),
                GestureDetector(
                  onTap: () {
                    _registrationValidation();
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: Dimensions.width30 * 4,
                      right: Dimensions.width30 * 4,
                    ),
                    height: Dimensions.screenHeight / 13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.themeColor,
                    ),
                    child: Center(
                      child: BigText(
                        text: "Sign Up",
                        size: Dimensions.font30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.height10),
                GestureDetector(
                  onTap: () => Get.toNamed(RouteHelper.getSignIn()),
                  child: Container(
                    height: Dimensions.height20,
                    margin: EdgeInsets.only(bottom: Dimensions.height10),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                            text: "Have an Account Already? ",
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: Dimensions.font10 * 1.6,
                            ),
                            children: [
                              TextSpan(
                                text: "Log In",
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
                ),
              ],
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
    ]);
  }

  void _registrationValidation() {
    setState(() {
      firstNameError = '';
      lastNameError = '';
      middleNameError = '';
      usernameError = '';
      passwordError = '';
      confirmPasswordError = '';
      emailError = '';
      phoneNumberError = '';
      termsError = ''; // Reset terms error

      String firstName = firstNameController.text.trim();
      String lastName = lastNameController.text.trim();
      String username = usernameController.text.trim();
      String password = passwordController.text.trim();
      String confirmPassword = confirmPasswordController.text.trim();
      String email = emailController.text.trim();
      String phoneNumber = phoneNumberController.text.trim();

      if (!_isTermsAccepted) {
        termsError = "You must accept the Privacy Policy to proceed";
        return;
      }

      if (firstName.isEmpty ||
          lastName.isEmpty ||
          username.isEmpty ||
          confirmPassword.isEmpty ||
          email.isEmpty ||
          !GetUtils.isEmail(email) ||
          password.length < 8 ||
          password != confirmPassword ||
          !GetUtils.isPhoneNumber(phoneNumber) ||
          phoneNumber.length != 10) {
        if (firstName.isEmpty) {
          firstNameError = "First name is required *";
        }
        if (lastName.isEmpty) {
          lastNameError = "Last name is required *";
        }
        if (username.isEmpty) {
          usernameError = "Username is required*";
        }
        if (password.isEmpty) {
          passwordError = "Password is required*";
        }
        if (confirmPassword.isEmpty) {
          confirmPasswordError = "Confirm Password is required*";
        }
        if (email.isEmpty) {
          emailError = "Email is required*";
        }
        if (!GetUtils.isEmail(email)) {
          emailError = "Invalid Email";
        }
        if (password.length < 8) {
          passwordError = "Password should be at least 8 characters";
        }
        if (password != confirmPassword) {
          confirmPasswordError = "Passwords Don't Match";
        }
        if (!GetUtils.isPhoneNumber(phoneNumber)) {
          phoneNumberError = "Invalid Phone Number*";
        }
        if (phoneNumber.length != 10) {
          phoneNumberError = "Phone Number should be 10 digits";
        }
      } else {
        setState(() {
          _isLoading = true;
        });
        SignUpRequest newUser = SignUpRequest(
            firstName: firstName,
            lastName: lastName,
            middleName: '',
            email: email,
            phoneNumber: phoneNumber,
            username: username,
            role: "ROLE_ADMIN",
            password: password);

        var authController = Get.find<AuthController>();
        authController.registration(newUser).then((status) {
          setState(() {
            _isLoading = false;
          });
          if (status.isSuccess) {
            AppConstant.isAccountRegistered = true;
            Get.toNamed(RouteHelper.getVerifyOTP());
            showCustomSnackBar(
                message: "Verify Your account",
                isError: false,
                title: "Registration Successful",
                color: Colors.green);
          } else {
            Get.snackbar("Error", status.message);
          }
        });
      }
    });
  }

  void _launchPrivacyPolicy() async {
    const url = 'https://bandobasta.com/privacy.html';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar(
        "Error",
        "Could not open the privacy policy",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void showCustomSnackBar(
      {required String message,
      required bool isError,
      required String title,
      required Color color}) {
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
