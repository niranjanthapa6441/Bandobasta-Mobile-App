import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:BandoBasta/widgets/small_text.dart';
import 'package:flutter/material.dart';

import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BigText(
        text: text,
        size: Dimensions.font10 * 2.6,
      ),
      SizedBox(
        height: Dimensions.height10,
      ),
      Row(
        children: [
          //ratings and comment section
          Wrap(
            children: List.generate(
              5,
              (index) => Icon(
                Icons.star,
                color: AppColors.mainColor,
                size: Dimensions.height15,
              ),
            ),
          ),
          SizedBox(
            width: Dimensions.width10,
          ),
          SmallText(
            text: "4.5",
            size: Dimensions.font15,
          ),
          SizedBox(
            width: 10,
          ),
          SmallText(
            text: "1287",
            size: Dimensions.font15,
          ),
          SizedBox(
            width: 10,
          ),
          SmallText(
            text: "Comments",
            size: Dimensions.font15,
          ),
        ],
      ),
      SizedBox(
        height: Dimensions.height15,
      ),
      //iconandtext section
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconAndTextWidget(
              icon: Icons.circle_sharp,
              text: "Normal",
              iconColor: AppColors.iconColor1),
          IconAndTextWidget(
              icon: Icons.location_on,
              text: "1.7 k.m.",
              iconColor: AppColors.mainColor),
          IconAndTextWidget(
              icon: Icons.access_time_rounded,
              text: "Normal",
              iconColor: AppColors.iconColor2),
        ],
      )
    ]);
  }
}
