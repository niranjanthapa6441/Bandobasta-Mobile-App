import 'package:bandobasta/utils/color/colors.dart';
import 'package:bandobasta/utils/dimensions/dimension.dart';
import 'package:bandobasta/widgets/big_text.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String btn_txt;
  final Color color;
  final double? buttonHeight;
  final double? buttonWidth;

  const AppButton({
    Key? key,
    required this.btn_txt,
    this.color = AppColors.buttonBackgroundColor,
    this.buttonHeight,
    this.buttonWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: buttonHeight ?? Dimensions.height55, // Use passed height or default
        width: buttonWidth ?? MediaQuery.of(context).size.width * 0.6, // Use passed width or default
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(Dimensions.radius20)),
        child: Center(
          child: BigText(
            text: btn_txt,
            color: Colors.white,
          ),
        ));
  }
}
