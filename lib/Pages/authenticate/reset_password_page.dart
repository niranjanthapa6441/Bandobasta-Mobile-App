import 'package:BandoBasta/Request/reset_password_request.dart';
import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/auth_controller.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your new password:',
              style: TextStyle(fontSize: Dimensions.font10 * 1.8),
            ),
            SizedBox(height: Dimensions.height10 * 2),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      hintText: 'Enter your new password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your new password';
                      } else if (value.length < 8 || value.length > 32) {
                        return 'Password must be between 8 and 32 characters';
                      } else if (!RegExp(
                              r"^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\S+$)")
                          .hasMatch(value)) {
                        return 'Password must contain at least one number, one lowercase letter, one uppercase letter, and one special character';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Dimensions.height10 * 2),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm your new password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your new password';
                      } else if (value != _newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Dimensions.height10 * 2),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.themeColor,
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.width10 * 1.4),
                            minimumSize:
                                Size(double.infinity, Dimensions.height10 * 5),
                          ),
                          child: const Text('Submit'),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      String newPassword = _newPasswordController.text.trim();

      var authController = Get.find<AuthController>();
      ResetPasswordRequest request = ResetPasswordRequest(
          email: AppConstant.email,
          password: newPassword,
          otp: AppConstant.otp);
      authController.resetPassword(request).then((status) {
        setState(() {
          _isLoading = false;
        });

        if (status.isSuccess) {
          showCustomSnackBar("Password Reset Successful",
              title: "Reset Password", color: Colors.green);
          Get.toNamed(RouteHelper.getSignIn());
        } else {
          showCustomSnackBar(status.message, title: "Error");
        }
      }).catchError((error) {
        setState(() {
          _isLoading = false;
        });
        showCustomSnackBar("An error occurred. Please try again.",
            title: "Error");
      });
    }
  }

  void showCustomSnackBar(String message,
      {bool isError = true, String title = "Error", Color color = Colors.red}) {
    Get.snackbar(
      title,
      message,
      titleText: Text(title, style: TextStyle(color: Colors.white)),
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
