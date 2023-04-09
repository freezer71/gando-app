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

import '../../models/Car.dart';
import '../../models/User.dart' as client;
import '../../services/auth/get_user_car.dart';

class UserController extends GetxController {
  late final Future getCarList;
  final RxList<Car> userCarList = <Car>[].obs;
  final Rx<TextEditingController> pinController = TextEditingController().obs;
  TextEditingController phoneTxtController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late StreamSubscription otpEventSubsc;
  Rx<client.User> user = Get.find<AuthService>().user;
  String countryCode = "+33";
  String? phoneNumber;
  String? idUser;
  final userID = ''.obs;
  final isLoading = false.obs;
  final UserRepository repository = GetIt.instance.get<UserRepository>();
  final OtpService otpService = GetIt.instance.get<OtpService>();
  String countryName = "France";
  DateTime currentDate = DateTime.now();
  String birthYear = DateTime.now().year.toString();
  String birthDay = DateTime.now().day.toString();
  String birthMonth = DateTime.now().month.toString();
  RxBool gearboxValue = false.obs;

  // detail contact screen
  Rx<TextEditingController> birthPlaceController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> complementController = TextEditingController().obs;

  Rx<TextEditingController> postalCodeController = TextEditingController().obs;
  Rx<TextEditingController> cityController = TextEditingController().obs;
  final Rx<bool> isSuccess = false.obs;
  Rx<String> initialSelectionCountry = "+33".obs;

  @override
  Future<void> onInit() async {
    // check if called route == annonce
    // userID(Get.parameters['id']!);
    getCarList = getUserCarList();
    birthPlaceController =
        TextEditingController(text: user.value.birthplace ?? "").obs;
    addressController =
        TextEditingController(text: user.value.address?.address ?? "").obs;
    complementController =
        TextEditingController(text: user.value.address?.complement ?? "").obs;
    postalCodeController =
        TextEditingController(text: user.value.address?.zipCode ?? "").obs;
    cityController =
        TextEditingController(text: user.value.address?.city ?? "").obs;
    initialSelectionCountry.value =
        user.value.phone == null || user.value.phone == ""
            ? "+33"
            : user.value.phone!.split(" ").first;
    countryCode = user.value.phone == null || user.value.phone == ""
        ? "+33"
        : user.value.phone!.split(" ").first;
    gearboxValue.value = user.value.civility == null ||
            user.value.civility == "" ||
            user.value.civility == "Mr"
        ? false
        : true;
    setState();
    super.onInit();
  }

  @override
  void onClose() {
    userCarList.clear();
    getCarList.ignore();
    super.onClose();
  }

  void setState() {
    descriptionController.text =
        user.value.description == null || user.value.description == " "
            ? "Aucun biographie"
            : "${user.value.description}";
    update();
  }

  //get user by id
  Future<client.User> getUserById() async {
    try {
      client.User _user = await repository.getUserById(id: idUser!);
      user.value = _user;
      return _user;
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 3));
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
      otpEventSubsc.cancel();
      Get.snackbar("Code envoyé par sms", "Veuillez verifié.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.secondaryColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 2));
      phoneTxtController.text = "";
      Get.toNamed(Routes.verifyPhoneCoordonate);
    } else if (action is VerificationFailedAction) {
      print('Otp Failed again');
      isLoading(false);
      otpEventSubsc.cancel();
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
      otpEventSubsc.cancel();
    }
  }

  Future<void> onVerifyCode() async {
    print('$logTrace with ${pinController.value.text}');
    isLoading(true);
    bool isVerifyCode =
        await otpService.verifyCode(smsCode: pinController.value.text);
    if (isVerifyCode) {
      otpEventSubsc.cancel();
      Get.snackbar('Code OK', "",
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.secondaryColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 3));
      isLoading(false);
      pinController.value.text = "";
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
    countryName = s.name!;
  }

  Future<void> editCoordonates() async {
    isLoading(true);
    print(
        "brithdate $birthYear-${birthMonth.padLeft(2, "0")}-${birthDay.padLeft(2, "0")}");
    try {
      Map<String, dynamic> data = {
        "civility": gearboxValue.value ? "Mme" : "Mr",
        "birthPlace": birthPlaceController.value.text,
        "birthDate":
            "$birthYear-${birthMonth.padLeft(2, "0")}-${birthDay.padLeft(2, "0")}",
        "address": addressController.value.text,
        "complement": complementController.value.text,
        "city": cityController.value.text,
        "country": countryName,
        "zipCode": postalCodeController.value.text,
        "phone": phoneNumber,
      };
      user.value = await repository.editCoordonates(data: data);
      Get.snackbar('Mise à jour', "Modification réussi.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.secondaryColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 3));
      isLoading(false);
      isSuccess(true);
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 3));
      isLoading(false);
      isSuccess(false);
    }
  }

  void onChangedBirthDate(
      {required String birthDayChanged,
      required String birthMonthChanged,
      required String birthYearChanged}) {
    birthDay = birthDayChanged;
    birthMonth = birthMonthChanged;
    birthYear = birthYearChanged;
  }
}
