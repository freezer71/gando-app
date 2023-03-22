


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gando/config/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../services/provider/api_provider.dart';

class AccountSettingController extends GetxController{

  static AccountSettingController get to => Get.find();

  final RxBool isLoading = false.obs;
  final RxBool isFirstOpen = false.obs;

  final box = GetStorage();

  Rx<TextEditingController> oldEmailController = TextEditingController().obs;
  Rx<TextEditingController> newEmailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> passwordConfirmController = TextEditingController().obs;

  final RxBool locationApp = false.obs;
  final RxBool locationSms = false.obs;
  final RxBool locationEmail = false.obs;

  final RxBool bookingApp = true.obs;
  final RxBool bookingSms = false.obs;
  final RxBool bookingEmail = false.obs;

  final RxBool messageApp = true.obs;

  final RxBool cancelBookingApp = false.obs;
  final RxBool cancelBookingSms = false.obs;

  final RxBool locationContractApp = true.obs;
  final RxBool locationContractSms = false.obs;
  final RxBool locationContractEmail = false.obs;

  final RxBool paymentApp = true.obs;
  final RxBool paymentEmail = false.obs;

  final RxBool gender = false.obs;
  RxBool gearboxValue = false.obs;

  RxString country = 'Pays'.obs;


  //edit profil
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> firstnameController = TextEditingController().obs;

  // detail contact screen
  Rx<TextEditingController> phoneNumber = TextEditingController().obs;
  Rx<TextEditingController> postalCodeController = TextEditingController().obs;
  Rx<TextEditingController> cityController = TextEditingController().obs;


  //social pages screen
  Rx<TextEditingController> socialFacebook = TextEditingController().obs;
  Rx<TextEditingController> socialInstagram = TextEditingController().obs;
  Rx<TextEditingController> socialTwitter = TextEditingController().obs;
  Rx<TextEditingController> socialLinkedin = TextEditingController().obs;



  @override
  void onReady() {
    super.onReady();
  }

  Future deleteAccount() async {
    try {
      isLoading(true);
      final res = await ApiProvider().dioConnect('/user/deleteAccount', null);

      if(res.statusCode == STATUS_OK) {
        Get.offAllNamed('/login');
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}