


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';

import '../../../config/constants.dart';
import '../../../helpers/global_function.dart';
import '../../../navigation.dart';
import '../../../services/auth/auth_services.dart';
import '../../../services/provider/api_provider.dart';
import '../../../services/provider/google_sign_in.dart';

class SocialAuthController extends GetxController{
  final box = GetStorage();

  final RxBool isLoading = false.obs;
  final CancelToken apiToken = CancelToken();
  final checkAuth = Get.put(AuthService());
  final gf = GlobalFunction();


  @override
  void onReady() {
    checkAuth.isLoggedIn.value ? Get.offNamed(Routes.home) : null;
    super.onReady();
  }

  Future signInWithGoogle() async{
    isLoading(true);

    try{
      final user = await GoogleSignInApi.login();

      // printInfo(info: '$user');

      if ( user == null) {
        Get.defaultDialog(title: 'Notification', content: const Text('Echec de connexion avec Google, réessayer s\'il vous plait'));
      }else {
        final data = {
          'id' : user.id,
          'name' : user.displayName,
          'email' : user.email,
          'avatar' : user.photoUrl,
          'code' : user.serverAuthCode
        };

        final res = await ApiProvider().dioConnect('/authentication/google', data);
        final body = res.data;

        if(res.statusCode == STATUS_OK){
          printInfo(info: "USER DATA BY SIGNING GOOGLE ==========> $body");
          checkAuth.authentication(token: body['token']);
          return Get.offAllNamed(Routes.home);
        }else{
          Get.defaultDialog(title: 'Notification', content: Text('Echec de connexion avec Google, réessayer s\'il vous plait'));
        }
      }
    }catch (error){
      Get.defaultDialog(title: 'Notification', content: Text('Echec de connexion avec Google, réessayer s\'il vous plait'));
      // Get.defaultDialog(content: Text('Echec de connexion avec Google, réessayer s\'il vous plait\n $error', style: GlobalStyle.authSignWith,));
    }finally{
      isLoading(false);
    }
  }

}