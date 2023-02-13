

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../config/constants.dart';
import '../../navigation.dart';
import '../../services/provider/api_provider.dart';

class AuthController extends GetxController {

  final Rx<TextEditingController> recoverPassword = TextEditingController().obs;
  final Rx<TextEditingController> confirmRecoverPassword = TextEditingController().obs;

  final Rx<TextEditingController> forgotEmailController = TextEditingController().obs;
  final Rx<TextEditingController> pinController = TextEditingController().obs;

  final forgotPasswordFormKey = GlobalKey<FormState>();

  final _isPremium = false.obs;
  set setIsPremium(bool newValue) => _isPremium.value = newValue;
  bool get isPremium => _isPremium.value;

  final isLoading = false.obs;
  final box = GetStorage();


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    forgotEmailController.value.dispose();
    forgotPasswordFormKey.currentState?.reset();
    recoverPassword.value.dispose();
    confirmRecoverPassword.value.dispose();
    pinController.value.dispose();
    super.dispose();
  }


  //forgot password
  Future<void> forgotPassword() async {
    try {
      isLoading(true);
      final data = {
        'email': forgotEmailController.value.text,
      };
      final res = await ApiProvider().dioConnect('/authentication/sendRecoveryCode', data);
      final body = res.data;
      if (res.statusCode == STATUS_OK) {
        printInfo(info: '${body['data']}');
        return Get.offNamed(Routes.resetPwd, arguments: {'email': forgotEmailController.value.text});
      }
    } catch (e) {
      Get.defaultDialog(
          title: 'Notification',
          content: const Text('Echec de connexion, réessayer s\'il vous plait'));
      printError(info: '$e');
    } finally {
      isLoading(false);
    }
  }

  //reset password
  Future<void> changePassword() async {
    try {
      isLoading(true);
      final data = {
        'email': Get.arguments['email'],
        'code': Get.arguments['otp'],
        'password': recoverPassword.value.text,
        'confirmPassword': confirmRecoverPassword.value.text,
      };
      final res = await ApiProvider().dioConnect('/authentication/resetPassword', data);
      final body = res.data;
      if (res.statusCode == STATUS_OK) {
        printInfo(info: '${body['data']}');
        return Get.offNamed(Routes.signIn);
      }
    } catch (e) {
      Get.defaultDialog(
          title: 'Notification',
          content: const Text('Echec de connexion, réessayer s\'il vous plait'));
      printError(info: '$e');
    } finally {
      isLoading(false);
    }
  }

  //verify pin
  Future<void> verifyPin() async {
    try {
      isLoading(true);
      final data = {
        'validedCode': pinController.value.text,
      };

      final res = await ApiProvider().dioConnect('/authentication/verifyEmail', data);
      final body = res.data;

      if (res.statusCode == STATUS_OK) {
        printInfo(info: '${body['data']}');
        return Get.offNamed(Routes.home);
      }
    } catch (e) {
      Get.defaultDialog(
          title: 'Notification',
          content: const Text('Echec de connexion, réessayer s\'il vous plait'));
      printError(info: '$e');
    } finally {
      isLoading(false);
    }
  }

}