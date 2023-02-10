// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {

  static final _googleSignIn = GoogleSignIn();

  static  Future<GoogleSignInAccount?> login() async => await _googleSignIn.signIn();

  static Future loginFacebook() async{
    /* final LoginResult result = await FacebookAuth.instance.login();
    // by default we request the email and the public profile
    // or FacebookAuth.i.login()
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
      final userData = await FacebookAuth.instance.getUserData();
      return accessToken;
    } else {
      return;
    }*/
  }
}