


import 'package:flutter/material.dart';
import 'package:gando/services/auth/auth_services.dart';
import 'package:gando/services/onboarding_services.dart';
import 'package:get/get.dart';

import '../navigation.dart';

class AuthMiddlewares extends GetMiddleware {
  @override
  int? get priority => 4;
  //check if user is logged in,
  //if not, redirect to login page
  final controller = Get.put(AuthService());

  @override
  RouteSettings? redirect(String? route) {
    printInfo(info : 'Auth is======> ${controller.isLoggedIn.value}');
    if (!controller.isLoggedIn.value) {
      return const RouteSettings(name: Routes.preLogin);
    }
    return null;
  }

}


class IsFirstOpen extends GetMiddleware {
  @override
  int? get priority => 5;
  final controller = Get.put(OnboardingService());

  @override
  RouteSettings? redirect(String? route) {
    printInfo(info : 'Onboarding is======> ${controller.isFirstOpen.value}');

    if (!controller.isFirstOpen.value) {
      return const RouteSettings(name: Routes.welcome);
    }
    return null;
  }

}


//create class require visitor
class RequireVisitor extends GetMiddleware {
  @override
  int? get priority => 6;

  final controller = Get.put(AuthService());

  @override
  RouteSettings? redirect(String? route) {
    printInfo(info : 'Visitor ======> ${controller.isLoggedIn.value}');

    //check if user is logged in,
    if (controller.isLoggedIn.value) {
      return const RouteSettings(name: Routes.home);
    }
    //if not, redirect to login page
    return null;
  }

}

