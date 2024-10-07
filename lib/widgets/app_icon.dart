import 'package:bandobasta/utils/dimensions/dimension.dart';
import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  const AppIcon(
      {super.key,
      required this.icon,
      this.backgroundColor = const Color(0xFFfcf4e4),
      this.iconColor = const Color(0xFF756d54),
      this.size = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(size == 0 ? Dimensions.font10 * 2 : size / 2),
        color: backgroundColor,
      ),
      child: Center(
        child: Icon(
          icon,
          size: size == 0 ? Dimensions.font10 * 4 / 1.5 : size / 1.5,
          color: iconColor,
        ),
      ),
    );
  }
}
