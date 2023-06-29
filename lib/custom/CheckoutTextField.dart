import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/styles.dart';

class CheckoutTextField extends StatelessWidget {
  final double width;
  final String labelText;
  final String hintText;
  final double hintTextSize;
  // final String initialValue;
  final Function(String?)? onChanged;
  final TextInputType textInputType;
  final double padding;
  final bool size;
  final bool onRegPage;
  final bool obscureText;
  final int minLine;
  final int? maxLine;
  final Color cursorColor;
  final TextEditingController? controller;

  CheckoutTextField(
      {required this.width,
      required this.labelText,
      required this.hintText,
      this.hintTextSize = 12,
      // required this.initialValue,
      required this.onChanged,
      this.textInputType = TextInputType.text,
      this.padding = 0,
      this.size = false,
      this.onRegPage = false,
      this.cursorColor = Colors.black,
      this.maxLine = null,
      this.minLine = 1,
      this.obscureText = false,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Container(
          width: width,
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Colors.black12),
            borderRadius: BorderRadius.circular(10),
            color: Styles.textFieldColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: TextFormField(
              controller: controller,
              onChanged: onChanged,
              obscureText: obscureText,
              cursorColor: cursorColor,
              minLines: minLine,
              maxLines: maxLine,
              keyboardType: textInputType,
              // initialValue: initialValue,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                // labelText: labelText,
                // labelStyle: TextStyle(fontSize: 16, color: Colors.white),
                hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.black38,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ));
  }
}
