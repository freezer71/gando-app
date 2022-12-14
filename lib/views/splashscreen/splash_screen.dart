import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double brandingLogoPosition = 0.30;

  @override
  void initState() {
    //like fetching login data in serveur or check token validite
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAllNamed(Routes.preLogin);
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        brandingLogoPosition = 0.50;
      });
    });
    super.initState();
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
            Container(
              alignment: Alignment.center,
              width: Get.width,
              height: Get.height,
              child: Container(
                width: 298,
                height: 297,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/logo-splash.png"),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
