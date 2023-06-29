import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../custom/CustomButton.dart';
import '../../custom/CustomTextField.dart';
import '../../utils/global.dart';
import '../splash_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeNamed = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final fieldText = TextEditingController();
  bool _isLoading = false;
  bool _isChanged = false;
  bool _leadingShow = false;
  var verificationId = '';

  void clearText() {
    fieldText.clear();
  }

  _getOTP(phoneNumber, BuildContext c) async {
    setState(() {
      _isLoading = true;
    });
    if (validatePhone(phoneNumber) == null) {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          // timeout: const Duration(seconds: 60),
          verificationCompleted: (phoneAuthCredential) async {
            await auth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (FirebaseAuthException e) {},
          codeSent: (String verificationId, int? resendToken) async {
            // String smsCode = 'xxxxxx';
            // PhoneAuthCredential credential = PhoneAuthProvider.credential(
            //     verificationId: verificationId, smsCode: smsCode);
            // await auth.signInWithCredential(credential);
            this.verificationId = verificationId;
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
      successToast("OTP Send Successfully", context);

      setState(() {
        _isChanged = true;
        _leadingShow = true;
      });
      clearText();
    } else {
      errorToast("please enter valid phone Number", c);
    }
    setState(() {
      _isLoading = false;
    });
  }

  _verifyOTP(String otp, BuildContext c) async {
    setState(() {
      _isLoading = true;
    });
    try {
      var credintials = await auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: otp));
      if (credintials.user != null) {
        Navigator.popAndPushNamed(context, SplashPage.routeNamed);
      } else {
        errorToast('Wrong OTP', context);
      }
    } catch (e) {
      errorToast('Wrong OTP', context);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _clear() {
    clearText();
    setState(() {
      _isLoading = false;
      _isChanged = false;
      _leadingShow = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var phoneNumber = '';
    var countryCode = '+91';
    var otp = '';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Visibility(
          visible: _leadingShow,
          child: InkWell(
            onTap: _clear,
            child: Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        // color: Colors.blueAccent,
        height: double.maxFinite,
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo to be added
              // Phone Number Text Field
              CustomTextField(
                width: 256,
                hintText: (!_isChanged) ? "PHONE NUMBER" : "OTP",
                // initialValue: "",
                labelText: "Enter Phone Number",
                onChanged: (!_isChanged)
                    ? (value) {
                        phoneNumber = value!;
                        print(countryCode + phoneNumber);
                      }
                    : (value) {
                        otp = value!;
                      },
                textInputType: TextInputType.number,
                controller: fieldText,
              ),
              SizedBox(
                height: 16,
              ),
              // Visibility(
              //   visible: _isChanged,
              //   child: CustomTextField(
              //     width: 200,
              //     hintText: "OTP",
              //     initialValue: "",
              //     labelText: "Enter OTP",
              //     onChanged: (value) {
              //       otp = value!;
              //       print("OTP = $otp");
              //     },
              //     textInputType: TextInputType.number,
              //   ),
              // ),
              // SizedBox(
              //   height: 16,
              // ),
              // Flexible(child: ),
              Padding(
                padding: const EdgeInsets.only(left: 256),
                // OTP Button
                child: CustomButton(
                  labelText: (!_isChanged) ? "GET OTP" : "GET IN",
                  isLoading: _isLoading,
                  onTap: () {
                    (!_isChanged)
                        ? _getOTP(countryCode + phoneNumber, context)
                        : _verifyOTP(otp, context);
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
