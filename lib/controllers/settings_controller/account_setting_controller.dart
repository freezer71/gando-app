


import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountSettingController extends GetxController{

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


  //edit profil
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> firstnameController = TextEditingController().obs;

}