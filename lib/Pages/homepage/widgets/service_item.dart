import 'package:flutter/material.dart';

import '../../../utils/color/colors.dart';
import '../../../utils/dimensions/dimension.dart';
import '../../../widgets/big_text.dart';

class ServiceItems extends StatelessWidget {
  const ServiceItems({super.key, required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: AppColors.themeColor,
          radius: Dimensions.radius15 + 13,
          child: Icon(
            icon,
            color: Colors.white,
            size: Dimensions.height20 + 4,
          ),
        ),
        SizedBox(height: Dimensions.height5),
        BigText(
          text: title,
          color: AppColors.mainBlackColor,
          size: Dimensions.font10,
          fontWeight: FontWeight.bold,
          maxLines: 2,
          textOverflow: TextOverflow.ellipsis, // Adjusted title size
        ),
      ],
    );
  }
}
