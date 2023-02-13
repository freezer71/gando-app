import 'package:flutter/material.dart';
import 'package:gando/config/constants.dart';
import 'package:gando/services/provider/api_provider.dart';
import 'package:get/get.dart';

import '../../navigation.dart';
import '../../services/auth/auth_services.dart';

class SignUpController extends GetxController{

  final terms = false.obs;
  final isLoading = false.obs;
  final passwordVisible = false.obs;
  final signUpFormKey = GlobalKey<FormState>();
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  final checkAuth = Get.put(AuthService());


  @override
  void onReady() {
    super.onReady();
  }

  Future register() async{
    try{
      isLoading(true);
      final data =  {
        'firstname' : nameController.value.text,
        'lastname' : lastNameController.value.text,
        'email' : emailController.value.text,
        'password' : passwordController.value.text
      };

      final res = await ApiProvider().dioConnect('/authentication/signup', data);
      final body = res.data['data'];

      if(res.statusCode == STATUS_OK){
        printInfo(info: '${body['data']}');
        checkAuth.authentication(token: body['token']);
        return Get.offNamed(Routes.resetPwd, arguments: {'previousPage': 'register'});
      }
    }catch(e){
      printError(info: '$e');
      Get.defaultDialog(title: 'Notification', content: const Text('Echec d\'inscription, réessayer s\'il vous plait'));
    }finally{
      isLoading(false);
    }
  }

}