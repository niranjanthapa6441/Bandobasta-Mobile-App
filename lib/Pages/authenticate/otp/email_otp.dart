import 'package:BandoBasta/Request/forgot_password_request.dart';
import 'package:BandoBasta/controller/auth_controller.dart';
import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:BandoBasta/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetEmailOTP extends StatefulWidget {
  const GetEmailOTP({super.key});

  @override
  State<GetEmailOTP> createState() => _GetEmailOTPState();
}

class _GetEmailOTPState extends State<GetEmailOTP> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your email address to reset your password:',
              style: TextStyle(fontSize: Dimensions.font10 * 1.8),
            ),
            SizedBox(height: Dimensions.height10 * 2),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Dimensions.height10 * 2),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: _submitForm,
                          child: const Text('Submit'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.themeColor,
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.width10 * 1.4),
                            minimumSize:
                                Size(double.infinity, Dimensions.height10 * 5),
                          ),
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

      ForgotPasswordRequest request =
          ForgotPasswordRequest(email: _emailController.text.trim());

      var authController = Get.find<AuthController>();

      authController.sendOTPEmail(request).then((status) {
        setState(() {
          _isLoading = false;
        });

        if (status.isSuccess) {
          AppConstant.email = _emailController.text.trim();
          Get.toNamed(RouteHelper.getVerifyOTP());
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
