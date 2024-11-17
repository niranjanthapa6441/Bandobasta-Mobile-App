import 'package:BandoBasta/controller/auth_controller.dart';
import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:BandoBasta/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPPage extends StatefulWidget {
  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();
  final TextEditingController _controller6 = TextEditingController();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();

  bool _isLoading = false;

  void _submitOTP() {
    String otp = _controller1.text +
        _controller2.text +
        _controller3.text +
        _controller4.text +
        _controller5.text +
        _controller6.text;

    if (otp.length == 6) {
      setState(() {
        _isLoading = true;
      });
      var authController = Get.find<AuthController>();

      authController.verifyOTP(otp).then((status) {
        setState(() {
          _isLoading = false;
        });

        if (status.isSuccess) {
          AppConstant.otp = otp;
          Get.toNamed(RouteHelper.getResetPasswordPage());
        } else {
          showCustomSnackBar(status.message, title: "Invalid OTP");
        }
      }).catchError((error) {
        setState(() {
          _isLoading = false;
        });
      });
    } else {
      showCustomSnackBar('Please enter a valid 6-digit OTP', isError: true);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
        backgroundColor: AppColors.themeColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.width10 * 5,
            vertical: Dimensions.height10 * 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter OTP',
              style: TextStyle(
                fontSize: Dimensions.font10 * 2.4,
                fontWeight: FontWeight.bold,
                color: AppColors.themeColor,
              ),
            ),
            SizedBox(height: Dimensions.height10 * 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildOTPTextField(_controller1, _focusNode1, _focusNode2),
                _buildOTPTextField(_controller2, _focusNode2, _focusNode3),
                _buildOTPTextField(_controller3, _focusNode3, _focusNode4),
                _buildOTPTextField(_controller4, _focusNode4, _focusNode5),
                _buildOTPTextField(_controller5, _focusNode5, _focusNode6),
                _buildOTPTextField(_controller6, _focusNode6, null),
              ],
            ),
            SizedBox(height: Dimensions.height10 * 3),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _submitOTP,
                    child: Text('Submit OTP'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.themeColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width10 * 5,
                          vertical: Dimensions.height10 * 1.5),
                      textStyle: TextStyle(fontSize: Dimensions.font10 * 1.8),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildOTPTextField(TextEditingController controller,
      FocusNode focusNode, FocusNode? nextFocusNode) {
    return SizedBox(
      width: Dimensions.width10 * 4.5,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: Dimensions.font10 * 2.4, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && nextFocusNode != null) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          }
        },
      ),
    );
  }
}
