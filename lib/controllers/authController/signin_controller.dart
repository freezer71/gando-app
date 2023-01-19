import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController{

  final terms = false.obs;
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

  Future login(email, password) async {
    //
  }

}