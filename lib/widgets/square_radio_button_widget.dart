import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:flutter/material.dart';

class SquareRadioButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const SquareRadioButton(
      {required this.isSelected, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Dimensions.width10 * 2.4,
        height: Dimensions.height10 * 2.4,
        decoration: BoxDecoration(
          border: Border.all(
              color: isSelected ? Colors.green : Colors.white,
              width: Dimensions.width10 * 0.2),
          color: isSelected ? Colors.green : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: isSelected
            ? Icon(
                Icons.check,
                size: Dimensions.height20,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
