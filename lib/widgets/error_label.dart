import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:flutter/material.dart';

class ErrorLabel extends StatelessWidget {
  final String? error;

  const ErrorLabel({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
      height: Dimensions.height20,
      alignment: Alignment.centerLeft,
      child: error == null || error!.isEmpty
          ? SizedBox(height: Dimensions.height20) // Empty space if no error
          : Text(
              error!,
              style:
                  TextStyle(color: Colors.red, fontSize: 12), // Style for error
            ),
    );
  }
}
