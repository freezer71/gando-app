import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/constants.dart';
import '../../navigation.dart';
import '../../services/auth/auth_services.dart';
import '../../services/provider/api_provider.dart';

class SignInController extends GetxController{

  final terms = false.obs;
  final isLoading = false.obs;
  final showPassword = false.obs;
  final formKey = GlobalKey<FormState>();
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

  Future signIn() async {
    try{
      isLoading(true);
      final data = {
        'email' : emailController.value.text,
        'password' : passwordController.value.text
      };
      final res = await ApiProvider().dioConnect('/authentication/signin', data);
      final body =  res.data;
      if(res.statusCode == STATUS_OK){
        printInfo(info: '${body['data']}');
        checkAuth.authentication(token: body['token'], user: body['user']);
        return Get.offNamed(Routes.home);
      }
    }catch(e){
      Get.defaultDialog(title: 'Notification', content: const Text('Echec de connexion, réessayer s\'il vous plait'));
      printError(info: '$e');
    }finally{
      isLoading(false);
    }
  }

}