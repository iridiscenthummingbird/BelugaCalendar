import 'package:firebase_auth/firebase_auth.dart';

class VerifyPhoneNumberParameters {
  final String phoneNumber;
  final PhoneVerificationCompleted verificationCompleted;
  final PhoneVerificationFailed verificationFailed;
  final PhoneCodeSent codeSent;
  final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout;
  final Duration timeout;

  VerifyPhoneNumberParameters({
    required this.phoneNumber,
    required this.verificationCompleted,
    required this.verificationFailed,
    required this.codeSent,
    required this.codeAutoRetrievalTimeout,
    required this.timeout,
  });
}
