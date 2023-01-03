import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{

  final terms = false.obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

}