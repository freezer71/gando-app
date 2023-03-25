import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gando/services/provider/api_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gando/models/User.dart' as client;

import '../../navigation.dart';

class AuthService extends GetxService {
  Future<AuthService> init() async => this;

  final RxBool isLoggedIn = false.obs;
  final GetStorage box = GetStorage();
  Rx<client.User> user = client.User().obs;

  @override
  void onReady() async {
    if (box.hasData('token') && box.read('token') != null) {
      box.write('authenticated', true);
      if (box.read('authenticated')) {
        isLoggedIn(true);
        printInfo(
            info:
                'User is authenticated from local storage : ${box.read('token')}');
      }
    }
    printInfo(info: 'AuthService is ready avec user.id ${user.value.id}');
    if (user.value.id == null) {
      await getUser();
    }
    printInfo(info: 'after getuser user.id ${user.value.id}');
    printInfo(info: 'User is authenticated : ${box.read('authenticated')}');
    printInfo(info: 'User token : ${box.read('token')}');
    super.onReady();
  }

  Future<void> handleSignOut() async => await GoogleSignIn().signOut();

  //authenticate user global function
  Future<void> authentication({token}) async {
    try {
      await box.write('token', token).then((value) async {
        await box.write('authenticated', true);
        isLoggedIn(true);
        printInfo(info: 'User is authenticated '.toLowerCase());
        await getUser();
        printInfo(info: 'User.id ${user.value.id} '.toLowerCase());
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getUser() async {
    try {
      final res = await ApiProvider().getData('/user');
      final body = jsonDecode(res.body)['data'];
      printInfo(info: "USER DAZTA ========>  : ${body}");

      if (res.statusCode == 200) {
        user.value = client.User.fromJson(body);
      } else {
        user.value = client.User();
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(
            bottom: 20,
          ),
          duration: const Duration(seconds: 10));
      user.value = client.User();
    }
  }

  Future<void> logout() async {
    await box.remove('token');
    await box.remove('authenticated');
    await handleSignOut();
    isLoggedIn(false);
    Get.offAllNamed(Routes.signIn);
    printInfo(info: 'User is logged out');
  }

  void setIsPremium(bool newValue) {
    isLoggedIn.value = newValue;
  }
}
