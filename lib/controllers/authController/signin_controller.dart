import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:get/get.dart';

import '../../bindings/init_bindings.dart';
import '../../config/constants.dart';
import '../../navigation.dart';
import '../../services/auth/auth_services.dart';
import '../../services/provider/api_provider.dart';

class SignInController extends GetxController {
  final terms = false.obs;
  final isLoading = false.obs;
  final showPassword = false.obs;
  final signInFormKey = GlobalKey<FormState>();
  final checkAuth = Get.put(AuthService());
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.close();
    passwordController.close();
    super.onClose();
  }

  @override
  void dispose() {
    emailController.value.dispose();
    passwordController.value.dispose();
    signInFormKey.currentState?.dispose();
    super.dispose();
  }

  Future signIn() async {
    try {
      isLoading(true);
      final data = {
        'email': emailController.value.text,
        'password': passwordController.value.text
      };
      final res =
          await ApiProvider().dioConnect('/authentication/signin', data);
      final body = res.data['data'];
      if (res.statusCode == STATUS_OK) {
        printInfo(info: '${body}');
        checkAuth.authentication(token: body['token']);
        return Get.offNamed(
          Routes.home,
          arguments: InitBindings(),
        );
      }
    } catch (e) {
      // split error message
      final error = e.toString().split(',')[1].split(':')[1];
      Get.defaultDialog(
        backgroundColor: AppTheme.darkColor,
        title: e.toString().split(',')[1].split(':')[0].toUpperCase(),
        content: Container(
          padding: const EdgeInsets.all(10.0),
          height: 70.0,
          decoration: BoxDecoration(
              color: AppTheme.redColor,
              borderRadius: BorderRadius.circular(10.0)),
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            '${error}',
            style: Theme.of(Get.context!).textTheme.headlineLarge!.copyWith(
                color: AppTheme.light,
                fontWeight: FontWeight.w400,
                fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
        ),
      );
      printError(info: '$error');
    } finally {
      isLoading(false);
    }
  }
}
