import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReferScreen extends StatefulWidget {
  static const String routeNamed = "ReferScreen";

  @override
  State<ReferScreen> createState() => _ReferScreenState();
}

class _ReferScreenState extends State<ReferScreen> {
  var referCode = "SURAJ3025";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: Container(
            child: Column(
          children: [
            SizedBox(height: 16),
            FloatingActionButton(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.blueAccent,
                ),
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        )),
        backgroundColor: Colors.blueAccent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 64),
                Center(
                  child: SizedBox(
                      height: size.height * 0.3,
                      width: size.width * 0.8,
                      child: SvgPicture.asset("assets/images/travel.svg")),
                ),
              ],
            ),
            Text(
              "Refer Your Friends, Earn Real Money",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Center(
              child: Container(
                  width: size.width * 0.75,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 3),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 22, top: 8, bottom: 8, right: 22),
                          child: Text(
                            referCode,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await Clipboard.setData(
                              ClipboardData(text: referCode));

                          success('Copied to Clipboard', context);

                          // copied successfully
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white, width: 3),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomRight: Radius.circular(25)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 22, top: 8, bottom: 8, right: 22),
                            child: Text(
                              "COPY",
                              style: TextStyle(
                                  color: Colors.blueAccent, fontSize: 22),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "1. ",
                        style: TextStyle(color: Colors.white),
                      ),
                      Flexible(
                        child: Text(
                          "The person has to use this refer code while booking package.",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "2. ",
                        style: TextStyle(color: Colors.white),
                      ),
                      Flexible(
                        child: Text(
                          "10% of the total package amount will be added to your wallet.",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "3. ",
                        style: TextStyle(color: Colors.white),
                      ),
                      Flexible(
                        child: Text(
                          "Minimum withdrawl amount from wallet is \u{20B9}1000.",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "4. ",
                        style: TextStyle(color: Colors.white),
                      ),
                      Flexible(
                        child: Text(
                          "Person using this code will get a discount of \u{20B9}100 on their package.",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.amber),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, left: 16, right: 16),
                      child: Center(
                        child: Text(
                          "Check Your Earnings",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),
              ],
            )
          ],
          // SVG
          // refer text
          // refer text
          // perks
          // check earnings
        ));
  }
}

void success(String s, BuildContext context) {
  var fToast = FToast();
  fToast.init(context);
  fToast.showToast(child: successIconWidget(s), gravity: ToastGravity.TOP);
}

Widget successIconWidget(String message) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.amber,
    ),
    child: Text(message,
        style: const TextStyle(color: Colors.white, fontSize: 16)),
  );
}
