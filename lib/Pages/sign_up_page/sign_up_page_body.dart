import 'package:bandobasta/Request/sign_up_request.dart';
import 'package:bandobasta/controller/auth_controller.dart';
import 'package:bandobasta/route_helper/route_helper.dart';
import 'package:bandobasta/utils/color/colors.dart';
import 'package:bandobasta/utils/dimensions/dimension.dart';
import 'package:bandobasta/widgets/app_text_field.dart';
import 'package:bandobasta/widgets/big_text.dart';
import 'package:bandobasta/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPageBody extends StatefulWidget {
  const SignUpPageBody({Key? key}) : super(key: key);

  @override
  State<SignUpPageBody> createState() => _SignUpPageBodyState();
}

class _SignUpPageBodyState extends State<SignUpPageBody> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: Dimensions.height10 * 6,
          ),
          Column(children: [
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(
                textEditingController: firstNameController,
                hintText:
                    firstNameError.isEmpty ? "First Name" : firstNameError,
                width: Dimensions.width10 * 40,
                color: firstNameError.isEmpty ? null : AppColors.themeColor,
                icon: Icons.person),
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(
                textEditingController: middleNameController,
                hintText: "Middle Name",
                icon: Icons.person,
                width: Dimensions.width10 * 40),
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(
                textEditingController: lastNameController,
                hintText: lastNameError.isEmpty ? "Last Name" : lastNameError,
                color: lastNameError.isEmpty ? null : AppColors.themeColor,
                icon: Icons.person,
                width: Dimensions.width10 * 40),
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(
                textEditingController: usernameController,
                hintText: usernameError.isEmpty ? "Username" : usernameError,
                color: usernameError.isEmpty ? null : AppColors.themeColor,
                icon: Icons.person,
                width: Dimensions.width10 * 40),
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(
              textEditingController: passwordController,
              hintText: passwordError.isEmpty ? "Password" : passwordError,
              color: passwordError.isEmpty ? null : AppColors.themeColor,
              icon: Icons.password,
              width: Dimensions.width10 * 40,
              isObscure: true,
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(
              textEditingController: confirmPasswordController,
              hintText: confirmPasswordError.isEmpty
                  ? "Confirm Password"
                  : confirmPasswordError,
              icon: Icons.password,
              color: confirmPasswordError.isEmpty ? null : AppColors.themeColor,
              width: Dimensions.width10 * 40,
              isObscure: true,
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(
              textEditingController: emailController,
              hintText: emailError.isEmpty ? "Email" : emailError,
              width: Dimensions.width10 * 40,
              icon: Icons.email,
              color: emailError.isEmpty ? null : AppColors.themeColor,
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(
                textEditingController: phoneNumberController,
                hintText: phoneNumberError.isEmpty
                    ? "Phone Number"
                    : phoneNumberError,
                width: Dimensions.width10 * 40,
                color: phoneNumberError.isEmpty ? null : AppColors.themeColor,
                icon: Icons.phone),
          ]),
          SizedBox(
            height: Dimensions.height30,
          ),
          GestureDetector(
            onTap: () {
              _registrationValidation();
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
              height: Dimensions.height10 * 5,
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
          SizedBox(
            height: Dimensions.height10,
          ),
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
    );
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

      String firstName = firstNameController.text.trim();
      String lastName = lastNameController.text.trim();
      String middleName = middleNameController.text.trim();
      String username = usernameController.text.trim();
      String password = passwordController.text.trim();
      String confirmPassword = confirmPasswordController.text.trim();
      String email = emailController.text.trim();
      String phoneNumber = phoneNumberController.text.trim();
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
          firstNameError = "First Name is Empty";
        }
        if (lastName.isEmpty) {
          lastNameError = "Last Name is Empty";
        }
        if (username.isEmpty) {
          usernameError = "Username is Empty";
        }

        if (password.isEmpty) {
          passwordError = "Password is Empty";
        }
        if (confirmPassword.isEmpty) {
          confirmPasswordError = "Confirm Password is Empty";
        }
        if (email.isEmpty) {
          emailError = "Email is Empty";
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
          phoneNumberError = "Invalid Phone Number";
        }
        if (phoneNumber.length != 10) {
          phoneNumberError = "Phone Number should be 10 digits";
        }
      } else {
        // Proceed with registration
        SignUpRequest newUser = SignUpRequest(
            firstName: firstName,
            lastName: lastName,
            middleName: middleName,
            email: email,
            phoneNumber: phoneNumber,
            username: username,
            role: "ROLE_ADMIN",
            password: password);

        var authController = Get.find<AuthController>();
        authController.registration(newUser).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getSignIn());
            customSnackBar(
                "Registration Successful! Please Verify Your Email Before logging In",
                title: "Registration");
          } else {
            // Handle registration error
            showCustomSnackBar("Registration Failed: ${status.message}",
                title: "Error");
          }
        });
      }
    });
  }

  customSnackBar(String message,
      {bool isError = true,
      String title = "Error",
      Color color = Colors.green}) {
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

  void showCustomSnackBar(String s, {required String title}) {}
}
