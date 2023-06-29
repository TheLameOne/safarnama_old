import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../utils/styles.dart';

class CustomButton extends StatelessWidget {
  final String labelText;
  final FontWeight labelTextWeight;
  final double sizelabelText;
  final Function onTap;
  final Color containerColor;
  final bool isLoading;

  const CustomButton(
      {required this.labelText,
      this.sizelabelText = 16,
      this.labelTextWeight = FontWeight.w500,
      required this.onTap,
      this.isLoading = false,
      this.containerColor = Colors.lightBlue});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 50,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [Styles.primaryColor, HexColor('9AE8FD')],
              begin: Alignment.bottomRight,
              end: Alignment.topRight,
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: (isLoading == false)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(labelText,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    ],
                  )
                : const SizedBox(
                    height: 20.0,
                    width: 20,
                    child: CircularProgressIndicator(color: Colors.blue),
                  ),
          ),
        ),
      ),
    );
  }
}
