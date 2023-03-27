import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gando/constants.dart';
import 'package:gando/services/phone/actions.dart';
import 'package:get_it/get_it.dart';

class OtpService {
  String? _phoneTry;
  String? _phone;
  final FirebaseAuth _auth = GetIt.instance.get<FirebaseAuth>();
  late String _verificationId;
  final _eventSink = StreamController.broadcast();
  StreamController get eventSink => _eventSink;

  Stream<dynamic> verifyPhoneNumber(String? phoneNumber) {
    final streamController = StreamController<dynamic>();
    print("ato amin verifyPhoneNumber");
    _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber!,
      timeout: const Duration(seconds: 30),
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
        print("ato amin verificationCompleted");

        streamController.add(VerificationCompleted(phoneAuthCredential));
      },
      verificationFailed: (FirebaseAuthException firebaseAuthException) {
        print("ato amin verificationFailed");

        streamController.add(VerificationFailedAction(firebaseAuthException));
      },
      codeSent: (String verificationId, int? b) {
        print("ato amin codesent");
        streamController.add(OtpCodeSentAction(verificationId));
      },
      codeAutoRetrievalTimeout: (String phoneAuthCredential) {
        print("ato amin codeAutoRetrievalTimeout");

        streamController.add(CodeAutoRetrievalTimeout(phoneAuthCredential));
      },
    );
    return streamController.stream;
  }

  Future<void> sendCode(String? phone) async {
    print("$logTrace $phone");
    this._phoneTry = phone;
    print("$logTrace verifyPhoneNumber on mobile");

    final stream = verifyPhoneNumber(phone);
    print("$logTrace streamController" + stream.toString());

    stream.listen((event) {
      print("$logTrace event " + event.toString());
      if (event is OtpCodeSentAction) {
        print("$logTrace OTP code result ${event.uid}");
        _verificationId = event.uid;
        eventSink.add(OtpCodeSentAction(event.uid));
        //_codeSent(event.uid);
      }
      if (event is VerificationCompleted) {
        _verificationCompleted(event.phoneAuthCredential);
      }
      if (event is VerificationFailedAction) {
        _verificationFailed(event.authException);
      }
      if (event is CodeAutoRetrievalTimeout) {
        // _codeAutoRetrievalTimeout(event.uid);
      }
    });
    if (this._phone == phone) {
      // When phone number is the same, user trying to resent otp again.
      // if previous otp still valid, just pretend that we sent a new one
      /*  if (!this._timerAllow()) {
        print('$logTrace Too fast. Wait until count down over');
        _eventSink.add(OtpCodeSentAction(''));
        return;
      }
    }*/
    }
  }

  Future _verificationCompleted(AuthCredential phoneAuthCredential) async {
    UserCredential authResult =
        await _auth.signInWithCredential(phoneAuthCredential);
    this.eventSink.add(VerificationAutoSuccess(authResult.user!.uid));
  }

  void _verificationFailed(FirebaseAuthException authException) {
    print("$logTrace You cant use emulator with real number, use test number "
        "https://stackoverflow.com/questions/45707173/this-app-is-not-authorized-to-use-firebase-authentication-in-emulator");

    this.eventSink.add(VerificationFailedAction(authException));
  }

  Future<bool> verifyCode({required String smsCode}) async {
    print(smsCode);
    bool isVerifyCode = false;
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: smsCode,
    );
    await _auth.signInWithCredential(credential).then((value) {
      if (value.user != null) {
        //  status = 'Authentication successful';
        isVerifyCode = true;
      } else {
        // status = 'Invalid code/invalid authentication';
        isVerifyCode = false;
      }
    }).catchError((error) {
      // status = 'Something has gone wrong, please try later';
      isVerifyCode = false;
    });
    print("isVerificydoe $isVerifyCode");
    return isVerifyCode;
  }
}
