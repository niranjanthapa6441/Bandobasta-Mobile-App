import 'package:bandobasta/utils/color/colors.dart';
import 'package:bandobasta/utils/dimensions/dimension.dart';
import 'package:flutter/material.dart';


class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;
  bool isObscure;
  final bool readOnly;
  final double width;
  Widget? widget;
  AppTextField(
      {Key? key,
      required this.textEditingController,
      required this.hintText,
      required this.icon,
      this.isObscure = false,
      this.readOnly = false,
      this.widget = null,
      required this.width 
      ,})
      : super(key: key);

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
                color: Colors.grey.withOpacity(0.2))
          ]),
      child: Row(
        children: [
          widget == null
              ? Container()
              : Container(
                  child: widget,
                ),
          Container(
            width: width,
            child: TextFormField(
              readOnly: readOnly,
              obscureText: isObscure ? true : false,
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: widget == null
                    ? Icon(
                        icon,
                        color: AppColors.mainBlackColor,
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
