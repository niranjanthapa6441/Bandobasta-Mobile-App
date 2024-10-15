
import 'package:bandobasta/utils/dimensions/dimension.dart';
import 'package:bandobasta/widgets/app_icon.dart';
import 'package:bandobasta/widgets/big_text.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({super.key, required this.appIcon, required this.bigText});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
          left: Dimensions.width20,
          top: Dimensions.height10,
          bottom: Dimensions.height10),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width30 * 2),
          bigText,
        ],
      ),
    );
  }
}
