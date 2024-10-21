import 'package:bandobasta/utils/color/colors.dart';
import 'package:bandobasta/utils/dimensions/dimension.dart';
import 'package:bandobasta/widgets/small_text.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({super.key, required this.text});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  int textLengthThreshold = 100; // A specific number of characters

  @override
  void initState() {
    super.initState();
    // Check if the text length exceeds the threshold to split into two parts
    if (widget.text.length > textLengthThreshold) {
      firstHalf = widget.text.substring(0, textLengthThreshold);
      secondHalf =
          widget.text.substring(textLengthThreshold, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(text: firstHalf)
          : Column(
              children: [
                SmallText(
                  text: hiddenText
                      ? (firstHalf + "....")
                      : (firstHalf + secondHalf),
                  size: Dimensions.font10 * 1.3,
                  color: AppColors.mainBlackColor,
                  height: Dimensions.height10 * 0.4,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                        text: hiddenText ? "Show More" : "Show Less",
                        color: AppColors.mainColor,
                        size: Dimensions.font10 * 1.3,
                      ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: AppColors.mainColor,
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
