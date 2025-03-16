import 'package:BandoBasta/utils/color/colors.dart';
import 'package:BandoBasta/utils/dimensions/dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;
  final bool isObscure;
  final bool readOnly;
  final double width;
  final Widget? widget;
  final Color? color; // Optional color for hint text
  final VoidCallback? onIconPressed; // Callback for icon press
  final List<TextInputFormatter>? inputFormatters; // Input formatters

  // Constructor to initialize parameters
  const AppTextField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.icon,
    this.isObscure = false,
    this.readOnly = false,
    this.widget,
    required this.width,
    this.color, // Optional color
    this.onIconPressed, // Initialize onIconPressed
    this.inputFormatters, // Initialize inputFormatters
  });

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
          Expanded(
            // Allow TextFormField to take available space
            child: TextFormField(
              readOnly: readOnly,
              obscureText: isObscure,
              controller: textEditingController,
              inputFormatters: inputFormatters, // Apply inputFormatters
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: color ?? Colors.grey, // Default hint color
                ),
                prefixIcon: widget == null
                    ? GestureDetector(
                        onTap: onIconPressed, // Invoke onIconPressed
                        child: Icon(
                          icon,
                          color: color ??
                              AppColors.mainBlackColor, // Default icon color
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
