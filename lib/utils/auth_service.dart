import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // AuthService._();
  // factory AuthService.getInstance() => _instance;
  // static final AuthService _instance = AuthService._();

  getOTP(String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        // timeout: const Duration(seconds: 60),
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {},
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  verifyOTP(phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        // timeout: const Duration(seconds: 60),
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (FirebaseAuthException e) {
          print(e);
        },
        codeSent: (String verificationId, int? resendToken) {},
        codeAutoRetrievalTimeout: (String verificationId) {});
  }
}
