import 'package:firebase_auth/firebase_auth.dart';

class OtpCodeSentAction {
  final String uid;
  OtpCodeSentAction(this.uid);
}

class CodeAutoRetrievalTimeout {
  final String uid;

  CodeAutoRetrievalTimeout(this.uid);
}

class VerificationAutoSuccess {
  final String uid;

  VerificationAutoSuccess(this.uid);
}

class VerificationFailedAction {
  final FirebaseAuthException authException;

  VerificationFailedAction(this.authException);
}

class VerificationCompleted {
  AuthCredential phoneAuthCredential;
  VerificationCompleted(this.phoneAuthCredential);
}
