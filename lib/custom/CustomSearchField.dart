import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/styles.dart';

class CustomSearchField extends StatelessWidget {
  final double width;
  final String labelText;
  final String hintText;
  final double hintTextSize;
  final String initialValue;
  final Function(String?)? onChanged;
  final TextInputType textInputType;
  final double padding;
  final bool size;
  final bool onRegPage;
  final bool obscureText;
  final int minLine;
  final int? maxLine;
  final Color cursorColor;
  final double height;
  final Color textColor;
  final bool border;

  CustomSearchField(
      {required this.width,
      required this.labelText,
      required this.hintText,
      this.hintTextSize = 12,
      required this.initialValue,
      required this.onChanged,
      this.textInputType = TextInputType.text,
      this.padding = 0,
      this.size = false,
      this.onRegPage = false,
      this.cursorColor = Colors.black,
      this.maxLine = null,
      this.minLine = 1,
      this.obscureText = false,
      this.height = 50,
      this.textColor = Colors.white,
      this.border = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromARGB(12, 0, 0, 0)),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
            color: Styles.textFieldColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: TextFormField(
              onChanged: onChanged,
              obscureText: obscureText,
              cursorColor: cursorColor,
              minLines: minLine,
              maxLines: maxLine,
              keyboardType: textInputType,
              initialValue: initialValue,
              style: TextStyle(fontSize: 16, color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                // labelText: labelText,
                // labelStyle: TextStyle(fontSize: 16, color: Colors.white),
                hintStyle: TextStyle(fontSize: 12, color: textColor),
              ),
            ),
          ),
        ));
  }
}
