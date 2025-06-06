import 'package:BandoBasta/Controller/user_controller.dart';
import 'package:BandoBasta/route_helper/route_helper.dart';
import 'package:BandoBasta/utils/auth_service/auth_service.dart';
import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:BandoBasta/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  final AuthService _authService = AuthService();
  bool isTokenExpired = false;

  @override
  void initState() {
    super.initState();
    checkTokenValidation();
    Get.find<UserController>().getCustomerDetails();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Account & Settings'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: Dimensions.height20),
            child: Column(
              children: [
                if (!isTokenExpired) _buildProfileSection(),
                Divider(),
                if (!isTokenExpired) _buildMenuItems(),
                Divider(),
                _buildSettingsItems(),
                Divider(),
                _buildSupportItems(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return GetBuilder<UserController>(builder: (userController) {
      var user = userController.user;
      return Container(
        padding: EdgeInsets.all(Dimensions.height20),
        child: Row(
          children: [
            AppIcon(
              icon: Icons.person,
              iconColor: Colors.white,
              backgroundColor: AppColors.themeColor,
              size: Dimensions.height10 * 10,
            ),
            SizedBox(width: Dimensions.width10 * 1.6),
            user?.firstName != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user?.firstName} ${user?.lastName}',
                        style: TextStyle(
                          fontSize: Dimensions.font18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: Dimensions.height5),
                      Text(
                        user?.email ?? 'Email',
                        style: TextStyle(fontSize: Dimensions.font10 * 1.4),
                      ),
                    ],
                  )
                : CircularProgressIndicator(),
          ],
        ),
      );
    });
  }

  Widget _buildMenuItems() {
    return Column(
      children: [
        _buildMenuItem(Icons.notifications, 'Notifications'),
        _buildMenuItem(Icons.person, 'Profile'),
        _buildMenuItem(Icons.business_center, 'Business Profile'),
        _buildMenuItem(Icons.bookmark, 'Saved Venue'),
        Divider(),
        _buildMenuItem(Icons.local_offer, 'Promo and Discount Codes'),
        _buildMenuItem(Icons.account_balance_wallet, 'Wallet'),
        _buildMenuItem(Icons.confirmation_number, 'Coupons'),
      ],
    );
  }

  Widget _buildSettingsItems() {
    return Column(
      children: [
        _buildMenuItem(Icons.language, 'Language'),
        _buildMenuItem(Icons.security, 'Permissions'),
      ],
    );
  }

  Widget _buildSupportItems() {
    return Column(
      children: [
        _buildMenuItem(Icons.support, 'Emergency Support'),
        _buildMenuItem(Icons.chat, 'Chat with us'),
        if (!isTokenExpired)
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: () {
              _authService.clearToken();
              _authService.clearUserId();
              Get.toNamed(RouteHelper.getSignIn());
            },
          )
        else
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Sign in'),
            onTap: () {
              Get.toNamed(RouteHelper.getSignIn());
            },
          ),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        if (title == "Profile") {
          Get.toNamed(RouteHelper.getViewProfile());
        }
      },
    );
  }

  void checkTokenValidation() async {
    bool expired = await _authService.isTokenExpired();
    setState(() {
      isTokenExpired = expired;
    });
  }
}
