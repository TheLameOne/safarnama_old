import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

abstract class Styles {
  static Color primaryColor = HexColor('7CD5F7');
  static const Color textFieldColor = Color.fromRGBO(255, 255, 255, 0.3);
  static TextStyle profileHeading = TextStyle(
      color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold);
  static TextStyle profileText = TextStyle(
      color: Colors.black45, fontSize: 12, fontWeight: FontWeight.bold);
}
