import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

var currentPage = 0;
var appTitle = "Fantasy Tour";
var heroHeading = "Explore the\nUnexplored";
const userId = "+917451985966";
int temp = 0;
double balance = 100;

String? validatePhone(String phone) {
  String? required = requiredString(phone);
  if (required != null) return required;

  RegExp regex = RegExp(r"^\+91\d{10}$");
  return (!regex.hasMatch(phone)) ? 'Valid Phone Number!!!' : null;
}

String? requiredString(String value) {
  if (value == null || value.isEmpty) return 'Required !!!';
  return null;
}

String? validateOtp(String otp) {
  String? required = requiredString(otp);
  if (required != null) return required;

  RegExp regex = RegExp(r"^\d{6}$");
  return (!regex.hasMatch(otp)) ? 'Valid Otp!!' : null;
}

String? validateEmail(String email) {
  if (email == null || email.isEmpty) return 'Required !!!';
  RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  return (!regex.hasMatch(email)) ? 'Valid Email!!' : null;
}

String? validateName(String name) {
  String? required = requiredString(name);
  if (required != null) return required;
  RegExp regex = RegExp(r'^[ a-zA-Z]*$');
  return (!regex.hasMatch(name)) ? 'Valid Name!!' : null;
}

void errorToast(String message, BuildContext context) {
  var fToast = FToast();
  fToast.init(context);
  fToast.showToast(
      child: customizedLeadingIconWidget(message), gravity: ToastGravity.TOP);
}

void successToast(String message, BuildContext context) {
  var fToast = FToast();
  fToast.init(context);
  fToast.showToast(
      child: successIconWidget(message), gravity: ToastGravity.TOP);
}

Widget customizedLeadingIconWidget(String message) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.black,
    ),
    child: Text(message,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
  );
}

Widget successIconWidget(String message) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Color.fromARGB(255, 18, 191, 222),
    ),
    child: Text(message,
        style: const TextStyle(color: Colors.white, fontSize: 16)),
  );
}
