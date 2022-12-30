import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/single_child_widget.dart';

import '../../navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double brandingLogoPosition = -0.075;

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    //like fetching login data in serveur or check token validite
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAllNamed(Routes.preLogin);
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        brandingLogoPosition = 0.10;
      });
    });
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));

    // setRotation(90);

    controller.addStatusListener((status) async{
      if(status == AnimationStatus.completed){
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
        color: const Color(0xFFEBEBEB),
        width: Get.width,
        height: Get.height,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Positioned(
              width: Get.width / 2,
              height: Get.height /2 ,
              top: 180,
              left: 110,
              child: AnimatedBuilder(
                animation: animation,
                child: Container(
                  width: 150,
                  height: 150,
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
            AnimatedContainer(
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
