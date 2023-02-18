// import 'package:gando/config.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gando/config/constants.dart';
import 'package:gando/config/textstyle.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../controllers/authController/social/social_auth_controller.dart';
import '../../../navigation.dart';
import '../../../widget/signInWith/signInWith.dart';

class PreLogin extends StatelessWidget {
  PreLogin({Key? key}) : super(key: key);

  final controller = Get.put(SocialAuthController());

  void onServiceClick(String serviceName) async{
    switch (serviceName) {
      case 'google':
        controller.signInWithSocial(serviceName);
        break;
      case 'facebook':
        // controller.signInWithFacebook();
        break;
      case 'apple':
        final credential =
            await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        print(credential);

        // This is the endpoint that will convert an authorization code obtained
        // via Sign in with Apple into a session in your system
        final signInWithAppleEndpoint = Uri(
          scheme: 'https',
          host: API_URL,
          path: '/sign_in_with_apple',
          queryParameters: <String, String>{
            'code': credential.authorizationCode,
            // if the user is authenticated
            if (credential.givenName != null)
              'firstName': credential.givenName!,
            if (credential.familyName != null)
              'lastName': credential.familyName!,
            if (credential.email != null)
              'email': credential.email!,
          },


        );
        controller.signInWithSocial(serviceName);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: Container(
          color: AppTheme.backgroundColor,
          width: Get.width,
          height: Get.height,
          child: Column(
            children: [
              SizedBox(
                width: Get.width,
                height: Get.height * 0.50,
                child: Container(
                  margin: EdgeInsets.only(top: (Get.height * 0.45) * 0.20),
                  child: Image.asset('assets/images/gando-logo.png'),
                ),
              ),
              SizedBox(
                width: Get.width * 0.65,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.signUp);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF292F36),
                  ),
                  child: const Text(
                    'LANCEZ-VOUS',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: Get.width,
                height: 30,
              ),
              Column(
                children: [
                  Platform.isIOS
                      ? SizedBox(
                       /* child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 58.0),
                          child: SignInWithAppleButton(
                              onPressed: () async {


                                // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
                                // after they have been validated with Apple (see `Integration` section for more information on how to do this)
                              },
                            ),
                        ),*/
                      )
                      : SignInWith(
                          const Color(0xFFFF6B6B),
                          FontAwesomeIcons.google,
                          "google",
                          Get.size,
                          onServiceClick,
                        ), //google sigIn
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  // SignInWith(
                  //   const Color(0xFF039BE5),
                  //   FontAwesomeIcons.facebookF,
                  //   "Facebook",
                  //   Get.size,
                  //   onServiseClick,
                  // ), //facebook sigIn
                  // const SizedBox(
                  //   height: 15,
                  // ),
                ],
              ),
              SizedBox(
                height: Get.height / 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Vous avez déja un compte ? ",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                          color: HexColor(AppTheme.primaryColorString!),
                        ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.signIn);
                    },
                    child: Text(
                      "Connectez-vous",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis,
                            color: AppTheme.primaryColor,
                          ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
