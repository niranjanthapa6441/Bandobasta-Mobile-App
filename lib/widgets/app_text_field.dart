import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;
  final bool isObscure;
  final bool readOnly;
  final double width;
  final Widget? widget;
  final Color? color; // Optional color for hint text
  final VoidCallback? onIconPressed; // New callback for icon press

  AppTextField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.icon,
    this.isObscure = false,
    this.readOnly = false,
    this.widget = null,
    required this.width,
    this.color, // Make color optional
    this.onIconPressed, // Initialize onIconPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius15),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            spreadRadius: 6,
            offset: Offset(1, 8),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: Row(
        children: [
          widget ?? Container(), // Display widget if not null
          Container(
            width: width,
            child: TextFormField(
              readOnly: readOnly,
              obscureText: isObscure,
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: color ?? Colors.grey, // Default hint color
                ),
                prefixIcon: widget == null
                    ? GestureDetector(
                        onTap: onIconPressed, // Toggle visibility
                        child: Icon(
                          icon,
                          color: color ?? AppColors.mainBlackColor,
                        ),
                      )
                    : null,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  borderSide: BorderSide(width: 1.0, color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  borderSide: BorderSide(width: 1.0, color: Colors.white),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
