import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../utils/styles.dart';

class CustomSearchButton extends StatelessWidget {
  final String labelText;
  final FontWeight labelTextWeight;
  final double sizelabelText;
  final Function onTap;
  final Color containerColor;
  final bool isLoading;
  final double width;
  final double height;

  const CustomSearchButton(
      {required this.labelText,
      this.sizelabelText = 16,
      this.labelTextWeight = FontWeight.w500,
      required this.onTap,
      this.isLoading = false,
      this.containerColor = Colors.lightBlue, this.height = 50, this. width =100});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            gradient: LinearGradient(
              colors: [Colors.amber, Colors.amber],
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
