// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'account_widget.dart';
// import 'big_text.dart';

// class NavigationDrawerWidget extends StatefulWidget {
//   const NavigationDrawerWidget({Key? key}) : super(key: key);

//   @override
//   State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
// }

// class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
//   final padding =
//       EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20);
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Container(
//         color: Color.fromARGB(255, 240, 239, 239),
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: AppColors.purpleColor,
//               ),
//               child: Center(
//                   child: BigText(text: "Swastik Air Hub", color: Colors.white)),
//             ),
//             SizedBox(
//               height: Dimensions.height10 * 4.8,
//             ),
//             GestureDetector(
//               onTap: () {
//                 Get.toNamed(RouteHelper.signIn);
//                 _eraseSignInDetails();
//               },
//               child: AccountWidget(
//                   appIcon: AppIcon(
//                     icon: Icons.signpost_outlined,
//                     iconColor: Colors.white,
//                     backgroundColor: AppColors.purpleColor,
//                     size: Dimensions.height10 * 5,
//                   ),
//                   bigText: BigText(
//                     text: "Sign Out",
//                     color: AppColors.purpleColor,
//                   )),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   void _eraseSignInDetails() {
//     AppConstants.USER_ID = "";
//   }
// }
