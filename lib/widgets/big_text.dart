import 'package:bandobasta/utils/dimensions/dimension.dart';
import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final TextOverflow textOverflow;
  final int? maxLines;
  final FontWeight fontWeight; // New fontWeight parameter

  BigText({
    Key? key,
    this.color = const Color(0xFF332d2b),
    required this.text,
    this.size = 0,
    this.textOverflow = TextOverflow.fade,
    this.maxLines, // Initialize maxLines
    this.fontWeight = FontWeight.w700, // Default font weight to normal
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 1, // Use maxLines parameter, default to 1 if null
      overflow: textOverflow,
      style: TextStyle(
        color: color,
        fontFamily: 'Roboto',
        fontSize: size == 0 ? Dimensions.font20 : size,
        fontWeight: fontWeight, // Use the provided fontWeight
      ),
    );
  }
}
