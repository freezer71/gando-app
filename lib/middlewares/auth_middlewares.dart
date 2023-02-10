


import 'package:flutter/material.dart';
import 'package:gando/services/auth/auth_services.dart';
import 'package:get/get.dart';

import '../navigation.dart';

class AuthMiddlewares extends GetMiddleware {
  @override
  int? get priority => 1;
  //check if user is logged in,
  //if not, redirect to login page
  final controller = Get.find<AuthService>();

  @override
  RouteSettings? redirect(String? route) {
    if (!controller.isLoggedIn.value) {
      return const RouteSettings(name: Routes.preLogin);
    }
    return null;
  }

}


