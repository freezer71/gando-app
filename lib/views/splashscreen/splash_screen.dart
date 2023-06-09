import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/single_child_widget.dart';

import '../../navigation.dart';
import '../../services/auth/auth_services.dart';
import '../../services/onboarding_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double brandingLogoPosition = 0.12;
  bool _visible = false;

  late AnimationController controller;
  late Animation<double> animation;

  bool isViewed = false;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 3000), () async{
      // init app
      if(!OnboardingService.to.isFirstOpen.value) {
        Get.offAllNamed(Routes.home);
      } else {
        Get.offAllNamed(Routes.welcome);
      }
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        brandingLogoPosition = 0.30;
        _visible = true;
      });
    });
    //like fetching login data in serveur or check token validite
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));

    // setRotation(90);
    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future.delayed(const Duration(seconds: 3));
        // controller.reset();
      }
    });

    setRotation(5);

    controller.forward(from: 0);
  }

  void setRotation(int degrees) {
    final angle = degrees * pi / 180;
    animation = Tween<double>(begin: -2.007, end: angle).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1000),
              child: AnimatedContainer(
                curve: Curves.bounceInOut,
                duration: const Duration(milliseconds: 500),
                alignment: Alignment(0, brandingLogoPosition),
                width: Get.width,
                height: Get.height,
                margin: const EdgeInsets.only(top: 40),
                child: Container(
                  width: 298,
                  height: 298,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/branding-icon.png"),
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: AnimatedOpacity(
                  opacity: _visible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: AnimatedBuilder(
                    animation: animation,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/logo-splash.png"),
                        ),
                      ),
                    ),
                    builder: (context, child) => Transform.rotate(
                      angle: animation.value,
                      child: child,
                    ),
                  ),
                ),
              ),
            ),

            // Container(
            //   alignment: Alignment.center,
            //   width: Get.width,
            //   height: Get.height,
            //   child: Container(
            //     width: 298,
            //     height: 297,
            //     decoration: const BoxDecoration(
            //       image: DecorationImage(
            //         image: AssetImage("assets/images/logo-splash.png"),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
