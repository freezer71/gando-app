// import 'package:gando/config.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gando/config/textstyle.dart';
import 'package:get/get.dart';

import '../../../controllers/authController/social/social_auth_controller.dart';
import '../../../navigation.dart';
import '../../../widget/signInWith/signInWith.dart';


class PreLogin extends StatelessWidget {
  PreLogin({Key? key}) : super(key: key);

  final controller = Get.put(SocialAuthController());

  void onServiceClick(String serviceName) {
    switch (serviceName) {
      case 'google':
        controller.signInWithSocial(serviceName);
        break;
      case 'facebook':
        // controller.signInWithFacebook();
        break;
      case 'apple':
        // controller.signInWithApple();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async{
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
                  ?
                    SignInWith(
                      const Color(0xFF000000),
                      FontAwesomeIcons.apple,
                      "apple",
                      Get.size,
                      onServiceClick,
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
