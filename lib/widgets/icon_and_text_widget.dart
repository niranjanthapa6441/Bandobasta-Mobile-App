import 'package:bandobasta/widgets/big_text.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions/dimension.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  double size;
  IconAndTextWidget(
      {Key? key,
      required this.icon,
      required this.text,
      required this.iconColor,
      this.size = 0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimensions.iconSize24,
        ),
        SizedBox(
          width: Dimensions.width5,
        ),
        BigText(
          text: text,
          size: size == 0 ? Dimensions.font15 : size,
          textOverflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
