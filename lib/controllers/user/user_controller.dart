import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/constants.dart';
import 'package:gando/navigation.dart';
import 'package:gando/services/auth/auth_services.dart';
import 'package:gando/services/phone/actions.dart';
import 'package:gando/services/phone/otp_service.dart';
import 'package:gando/services/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../config/constants.dart';
import '../../models/Car.dart';
import '../../models/User.dart' as client;
import '../../models/UserCar.dart';
import '../../services/auth/get_user_car.dart';

class UserController extends GetxController {
  late final Future getCarList;
  final RxList<Car> userCarList = <Car>[].obs;
  final Rx<TextEditingController> pinController = TextEditingController().obs;
  TextEditingController phoneTxtController = TextEditingController();
  late StreamSubscription otpEventSubsc;
  Rx<client.User> user = Get.find<AuthService>().user;
  String countryCode = "+33";
  String? phoneNumber;

  String? idUser;

  final userID = ''.obs;

  final isLoading = false.obs;
  final UserRepository repository = GetIt.instance.get<UserRepository>();
  final OtpService otpService = GetIt.instance.get<OtpService>();

  @override
  Future<void> onInit() async {
    super.onInit();
    // check if called route == annonce
    // userID(Get.parameters['id']!);
    getCarList = getUserCarList();
    // check called route name and get user id
  }

  @override
  void onClose() {
    userCarList.clear();
    getCarList.ignore();
    super.onClose();
  }

  void setState() {
    update();
  }

  //get user by id
  Future<client.User> getUserById() async {
    try {
      print("idUser $idUser");
      client.User _user = await repository.getUserById(id: idUser!);
      user.value = _user;
      return _user;
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 5));
      return client.User();
    }
  }

  // get user from api
  Future getUserCarList() async {
    try {
      isLoading(true);
      userCarList.value = await CarService().fetchUserCarList();
      if (userCarList.isNotEmpty) {
        return userCarList;
      } else {
        return <Car>[];
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3));
    } finally {
      isLoading(false);
      update();
    }
  }

  Future fetchCars() async {
    try {
      isLoading(true);
      final cars = await CarService().fetchUserCarList();
      userCarList.assignAll(cars);
    } finally {
      isLoading(false);
    }
  }

  Future<void> handleSigninWithPhone() async {
    print('$logTrace Attempt to verify phone ${phoneTxtController.text}');
    isLoading(true);
    if (countryCode == null) {
      phoneNumber = phoneTxtController.text;
    } else {
      phoneNumber = countryCode + ' ' + phoneTxtController.text;
    }
    await otpService.sendCode(phoneNumber);
    otpEventSubsc = otpService.eventSink.stream.listen(onOptEvent);
  }

  void onOptEvent(action) {
    print('$logTrace $action');

    if (action is OtpCodeSentAction) {
      print('Ack OtpCodeSentAction');
      isLoading(false);
      Get.snackbar("Code envoyé par sms", "Veuillez verifié.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.secondaryColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 2));
      Get.toNamed(Routes.verifyPhoneCoordonate);
    } else if (action is VerificationFailedAction) {
      print('Otp Failed again');
      isLoading(false);
      Get.snackbar("La vérification du numéro de téléphone a échoué.",
          "Code: ${action.authException.code}.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.redColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 2));
    } else if (action is VerificationAutoSuccess) {
      print('$logTrace Verified automatically');
      isLoading(false);
    }
  }

  Future<void> onVerifyCode() async {
    print('$logTrace with ${pinController.value.text}');
    isLoading(true);
    bool isVerifyCode =
        await otpService.verifyCode(smsCode: pinController.value.text);
    if (isVerifyCode) {
      Get.snackbar('Code OK', "",
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.secondaryColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 3));
      isLoading(false);
      Get.toNamed(Routes.detailCordonate);
      return;
    }
    Get.snackbar('Error', "Code SMS invalide)",
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppTheme.redColor,
        margin: const EdgeInsets.only(
          top: 20,
        ),
        duration: const Duration(seconds: 3));
    isLoading(false);
  }

  void onCountryCodePicked(CountryCode s) {
    print('$logTrace Country code changed ${s.dialCode}');
    countryCode = s.dialCode!;
  }
}
