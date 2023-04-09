import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:gando/generated/assets.dart';
import 'package:gando/services/auth/auth_services.dart';
import 'package:gando/services/onboarding_services.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

import '../config/textstyle.dart';
import '../navigation.dart';


class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: AppTheme.primaryColor,
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: OnBoardingSlider(
          pageBackgroundColor: AppTheme.primaryColor,
          hasFloatingButton: true,
          headerBackgroundColor: AppTheme.primaryColor,
          finishButtonText: 'Commencer',
          skipIcon: Icon(
            Icons.arrow_forward, color: AppTheme.primaryColor, size: 30,),
          finishButtonTextStyle: Theme
              .of(context)
              .textTheme
              .bodyText2!
              .copyWith(
              color: AppTheme.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w900),
          // skipTextButton: Text('Suivant'),
          // trailing: Text('Login'),
          onFinish: () async =>
            await GetStorage().write('onboarding', false).then((value) {
              OnboardingService.to.isFirstOpen.value = false;
              // printInfo(info: 'ONBOARDING +++++++++++============----${GetStorage().read('onboarding')}');
              return Get.offNamed(
                  Routes.preLogin, arguments: {'isFirstOpen': false});
          }),
          background: [
            Container(
              width: Get.width,
              height: Get.height,
              color: AppTheme.primaryColor,
              child: Center(child: Column(
                children: [
                  const SizedBox(height: 80,),
                  LottieBuilder.asset(Assets
                      .lotties128154DriverSteeringWheelMapMarkerTaxiRentCarSharing),
                  Text('Bienvenue sur Gando', style: Theme
                      .of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(
                      color: AppTheme.light,
                      fontSize: 32,
                      fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,),
                ],
              ),),
            ), Container(
              width: Get.width,
              height: Get.height,
              color: AppTheme.primaryColor,
              child: Center(child: Column(
                children: [
                  const SizedBox(height: 80,),
                  LottieBuilder.asset(Assets.lottiesSuccess),
                  Text('Louer votre véhicule', style: Theme
                      .of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(
                      color: AppTheme.light,
                      fontSize: 32,
                      fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,),
                ],
              ),),
            ), Container(
              width: Get.width,
              height: Get.height,
              color: AppTheme.primaryColor,
              child: Center(child: Text('Réserver c\'est à vous', style: Theme
                  .of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(
                  color: AppTheme.light,
                  fontSize: 32,
                  fontWeight: FontWeight.w900), textAlign: TextAlign.center,),),
            ),
          ],
          totalPage: 3,
          speed: 1.8,
          pageBodies: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: Get.height * .63,
                  ),
                  Text('Louez des voitures locales abordables', style: Theme
                      .of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(
                      color: AppTheme.light,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 480,
                  ),
                  Text('Économisez sur les frais de location', style: Theme
                      .of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(
                      color: AppTheme.light,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 480,
                  ),
                  Text('Location flexible auprès de particuliers', style: Theme
                      .of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(
                      color: AppTheme.light,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,),
                ],
              ),
            ),
          ],
        ),
      );
  }

}
