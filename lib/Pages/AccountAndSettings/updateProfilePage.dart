import 'package:BandoBasta/Controller/user_controller.dart';
import 'package:BandoBasta/Request/update_profile_request.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/dimensions/dimension.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  var emailController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var middleNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(' Update Profile'),
      ),
      body: Container(
        margin: EdgeInsets.only(
            left: Dimensions.width10, right: Dimensions.width10),
        child: ListView(
          children: [
            Column(children: [
              Container(
                height: Dimensions.height25,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              AppTextField(
                textEditingController: firstNameController,
                hintText: "First Name",
                icon: Icons.person,
                width: Dimensions.width10 * 30,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              AppTextField(
                textEditingController: middleNameController,
                hintText: "Middle Name",
                icon: Icons.person,
                width: Dimensions.width10 * 30,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              AppTextField(
                textEditingController: lastNameController,
                hintText: "Last Name",
                icon: Icons.person,
                width: Dimensions.width10 * 30,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              AppTextField(
                textEditingController: emailController,
                hintText: "Email",
                icon: Icons.email,
                width: Dimensions.width10 * 30,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              AppTextField(
                textEditingController: phoneNumberController,
                hintText: "Phone Number",
                icon: Icons.phone,
                width: Dimensions.width10 * 30,
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
                _validation();
              },
              child: Container(
                margin: EdgeInsets.only(
                    left: Dimensions.width30 + Dimensions.width30,
                    right: Dimensions.width30 + Dimensions.width30,
                    bottom: Dimensions.height50),
                height: Dimensions.screenHeight / 14,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: AppColors.themeColor,
                ),
                child: Center(
                  child: BigText(
                    text: "Update",
                    size: Dimensions.font20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _validation() async {
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String middleName = middleNameController.text.trim();
    String email = emailController.text.trim();
    String phoneNumber = phoneNumberController.text.trim();
    if (firstName.isEmpty) {
      showCustomSnackBar("First Name is Empty", title: "First Name");
    } else if (lastName.isEmpty) {
      showCustomSnackBar("Last Name is Empty", title: "Last Name");
    } else if (email.isEmpty) {
      showCustomSnackBar("Email is Empty", title: "Email");
    } else if (phoneNumber.isEmpty) {
      showCustomSnackBar("Phone Number is Empty", title: "Phone Number");
    } else if (!GetUtils.isEmail(email)) {
      showCustomSnackBar("Invalid Email", title: "Email");
    } else if (!phoneNumber.isPhoneNumber) {
      showCustomSnackBar("In Valid Phone Number", title: "PhoneNumber");
    } else if (phoneNumber.length < 10 || phoneNumber.length > 10) {
      showCustomSnackBar("Phone Number Should be 10", title: "PhoneNumber");
    } else {
      UpdateProfileRequest newUser = UpdateProfileRequest(
          firstName: firstName,
          lastName: lastName,
          middleName: middleName,
          email: email,
          phoneNumber: phoneNumber);
      var userController = Get.find<UserController>();
      userController.updateProfile(newUser).then((status) {
        if (status.isSuccess) {
          Get.back();
          Get.find<UserController>().getCustomerDetails();
          showCustomSnackBar("The details have been updated",
              title: "Profile Update", color: Colors.green);
        } else {
          showCustomSnackBar(status.message,
              title: "Update Profile", color: Colors.red);
        }
      });
    }
  }

  void showCustomSnackBar(String message,
      {required String title, MaterialColor? color}) {
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
