import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final double height;
  final TextOverflow textOverflow;
  final int maxLines;

  SmallText({
    Key? key,
    this.color = const Color(0xFFccc7c5),
    required this.text,
    this.size = 0,
    this.height = 0,
    this.maxLines = 1, // Set default to 1 line
    this.textOverflow = TextOverflow.ellipsis, // Set default to ellipsis
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: textOverflow,
      style: TextStyle(
        color: color,
        fontFamily: 'Montserrat',
        fontSize: size == 0 ? Dimensions.font10 + 2 : size,
        height: height == 0 ? Dimensions.height10 * 0.12 : height,
        letterSpacing: 1.0,
      ),
      textAlign: TextAlign.center,
    );
  }
}
