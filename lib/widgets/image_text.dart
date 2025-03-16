import 'package:BandoBasta/utils/color/colors.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions/dimension.dart';
import 'big_text.dart';

class ImageAndTextWidget extends StatelessWidget {
  final String imageURl;
  final String text;
  const ImageAndTextWidget(
      {super.key, required this.imageURl, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: Dimensions.height10 * 12,
          height: Dimensions.height10 * 12,
          margin: EdgeInsets.only(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius20),
            color: Colors.white38,
            image: DecorationImage(
              image: AssetImage(imageURl),
            ),
          ),
        ),
        SizedBox(
          width: Dimensions.width20 * 3,
        ),
        BigText(
            text: text, size: Dimensions.font20, color: AppColors.textColor),
      ],
    );
  }
}
