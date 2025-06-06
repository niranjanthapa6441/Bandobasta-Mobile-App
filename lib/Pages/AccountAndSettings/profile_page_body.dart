import 'package:BandoBasta/Controller/user_controller.dart';
import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/app_constants/app_constant.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:BandoBasta/widgets/account_widget.dart';
import 'package:BandoBasta/widgets/app_icon.dart';
import 'package:BandoBasta/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePageBody extends StatefulWidget {
  const ProfilePageBody({super.key});

  @override
  _ProfilePageBodyState createState() => _ProfilePageBodyState();
}

class _ProfilePageBodyState extends State<ProfilePageBody> {
  @override
  void initState() {
    super.initState();
    Get.find<UserController>().getCustomerDetails();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (userController) {
      var user = userController.user;
      if (user == null) {
        return Center(
            child: Container(
          child: Center(
            child: Text("User not logged in"),
          ),
        ));
      }

      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: Dimensions.height20),
              child: Center(
                child: AppIcon(
                  icon: Icons.person,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.themeColor,
                  size: Dimensions.height10 * 15,
                ),
              ),
            ),
            SizedBox(height: Dimensions.height20),

            // First Name
            AccountWidget(
              appIcon: AppIcon(
                icon: Icons.person,
                iconColor: Colors.white,
                backgroundColor: AppColors.themeColor,
                size: Dimensions.height10 * 4,
              ),
              bigText: BigText(
                size: Dimensions.font10 * 1.6,
                text: user.firstName ?? 'First Name',
                color: AppColors.textColor,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: Dimensions.height20),

            // Middle Name
            AccountWidget(
              appIcon: AppIcon(
                icon: Icons.person,
                iconColor: Colors.white,
                backgroundColor: AppColors.themeColor,
                size: Dimensions.height10 * 4,
              ),
              bigText: BigText(
                size: Dimensions.font10 * 1.6,
                text: user.middleName?.isEmpty == true
                    ? 'Middle Name'
                    : user.middleName ?? 'Middle Name', // Null and empty check
                color: AppColors.textColor,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: Dimensions.height20),

            // Last Name
            AccountWidget(
              appIcon: AppIcon(
                icon: Icons.person,
                iconColor: Colors.white,
                backgroundColor: AppColors.themeColor,
                size: Dimensions.height10 * 4,
              ),
              bigText: BigText(
                size: Dimensions.font10 * 1.6,
                text: user.lastName ?? 'Last Name',
                color: AppColors.textColor,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: Dimensions.height20),

            // Email
            AccountWidget(
              appIcon: AppIcon(
                icon: Icons.email_outlined,
                iconColor: Colors.white,
                backgroundColor: AppColors.themeColor,
                size: Dimensions.height10 * 4,
              ),
              bigText: BigText(
                size: Dimensions.font10 * 1.6,
                text: user.email ?? 'Email',
                color: AppColors.textColor,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: Dimensions.height20),

            AccountWidget(
              appIcon: AppIcon(
                icon: Icons.phone_android,
                iconColor: Colors.white,
                backgroundColor: AppColors.themeColor,
                size: Dimensions.height10 * 4,
              ),
              bigText: BigText(
                size: Dimensions.font10 * 1.6,
                text: user.phoneNumber ?? 'Phone Number',
                color: AppColors.textColor,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: Dimensions.height10),

            GestureDetector(
              onTap: () {
                AppConstant.user = user;
                Get.toNamed(RouteHelper.getUpdateProfile());
              },
              child: Container(
                margin: EdgeInsets.only(
                  top: Dimensions.height10,
                  left: Dimensions.width30 + Dimensions.width30 * 3,
                  right: Dimensions.width30 + Dimensions.width30 * 3,
                ),
                height: Dimensions.screenHeight / 19,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: AppColors.themeColor,
                ),
                child: Center(
                  child: BigText(
                    text: "Edit Profile",
                    size: Dimensions.font20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
