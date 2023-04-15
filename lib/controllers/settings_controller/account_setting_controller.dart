import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/models/notification/notification_type.dart';
import 'package:gando/navigation.dart';
import 'package:gando/services/auth/auth_services.dart';
import 'package:gando/services/repositories/user_repository.dart';
import 'package:gando/config/constants.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gando/services/provider/api_provider.dart';
import 'package:gando/models/User.dart' as client;

class AccountSettingController extends GetxController {
  static AccountSettingController get to => Get.find();

  final RxBool isLoading = false.obs;
  final RxBool isLoadingDeleteUser = false.obs;
  final RxBool isLoadingInitEditMailUser = false.obs;
  final RxBool isLoadingEditPassword = false.obs;
  final RxBool isFirstOpen = false.obs;
  final Rx<bool> isSuccess = false.obs;

  final box = GetStorage();

  Rx<TextEditingController> oldEmailController = TextEditingController().obs;
  Rx<TextEditingController> newEmailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> passwordControllerDelete =
      TextEditingController().obs;
  Rx<TextEditingController> passwordControllerMail =
      TextEditingController().obs;
  Rx<TextEditingController> currentPasswordController =
      TextEditingController().obs;
  Rx<TextEditingController> passwordConfirmController =
      TextEditingController().obs;

  final RxBool gender = false.obs;

  //edit profil
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> firstnameController = TextEditingController().obs;

  //social pages screen
  Rx<TextEditingController> socialFacebook = TextEditingController().obs;
  Rx<TextEditingController> socialInstagram = TextEditingController().obs;
  Rx<TextEditingController> socialTwitter = TextEditingController().obs;
  Rx<TextEditingController> socialLinkedin = TextEditingController().obs;
  final Rx<TextEditingController> pinController = TextEditingController().obs;
  final UserRepository repository = GetIt.instance.get<UserRepository>();
  Rx<client.User> user = Get.find<AuthService>().user;

  List<String> titleNotificationList = [
    'Demande de locations',
    'Confirmation de réservation',
    'Messages',
    'Annulation de réservation',
    'Contrat de location',
    'Paiement',
  ];
  RxList<bool> listCheckBoxApp = <bool>[].obs;
  RxList<bool> listCheckBoxEmail = <bool>[].obs;

  void initListCheckBox() {
    NotificationType? notificationType = user.value.notification;
    listCheckBoxApp.value = [
      notificationType!.locationAsk!.app!,
      notificationType.rentConfirmation!.app!,
      notificationType.message!.app!,
      notificationType.rentAbort!.app!,
      notificationType.contract!.app!,
      notificationType.pay!.app!,
    ];
    listCheckBoxEmail.value = [
      notificationType.locationAsk!.mail!,
      notificationType.rentConfirmation!.mail!,
      notificationType.message!.mail!,
      notificationType.rentAbort!.mail!,
      notificationType.contract!.mail!,
      notificationType.pay!.mail!,
    ];
    print("tafiditra  ve 2222");
  }

  Future deleteAccount() async {
    try {
      isLoading(true);
      final res = await ApiProvider().dioConnect('/user/deleteAccount', null);

      if (res.statusCode == STATUS_OK) {
        Get.offAllNamed('/login');
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  Future<void> editPassword() async {
    isLoadingEditPassword(true);
    try {
      Map<String, dynamic> data = {
        "newPassword": passwordController.value.text,
        "currentPassword": currentPasswordController.value.text,
      };
      await repository.editPassword(data: data);
      Get.snackbar('Mise à jour', "Enregistré avec succés",
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.secondaryColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 3));
      isLoadingEditPassword(false);
      isSuccess(true);
      passwordController.value.text = "";
      currentPasswordController.value.text = "";
      passwordConfirmController.value.text = "";
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.redColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 3));
      isLoadingEditPassword(false);
      isSuccess(false);
    }
  }

  Future<void> initEditMailUser() async {
    isLoadingInitEditMailUser(true);
    try {
      Map<String, dynamic> data = {
        "newEmail": newEmailController.value.text,
        "password": passwordControllerMail.value.text,
      };
      await repository.initEditMail(data: data);
      Get.snackbar('Code de verification', "Veuillez vérifier votre mail",
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.secondaryColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 3));
      isLoadingInitEditMailUser(false);
      newEmailController.value.text = "";
      passwordControllerMail.value.text = "";
      Get.toNamed(Routes.verifyMail);
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.redColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 3));
      isLoadingInitEditMailUser(false);
      isSuccess(false);
    }
  }

  Future<void> verifyMailUser() async {
    isLoading(true);
    try {
      Map<String, dynamic> data = {
        "validedCode": pinController.value.text,
      };
      await repository.verifyMail(data: data);
      Get.snackbar('Mise à jour', "Enregistré avec succés",
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
          backgroundColor: AppTheme.redColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 3));
      isLoading(false);
      isSuccess(false);
    }
  }

  Future<void> deleteUser() async {
    isLoadingDeleteUser(true);
    try {
      Map<String, dynamic> data = {
        "password": passwordControllerDelete.value.text,
      };
      await repository.delete(data: data);
      Get.snackbar('Mise à jour', "Suppression de votre compte avec succés",
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.secondaryColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 3));
      isLoadingDeleteUser(false);
      isSuccess(true);
      passwordControllerDelete.value.text = "";
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.redColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 3));
      isLoadingDeleteUser(false);
      isSuccess(false);
    }
  }

  void updateListCheckboxApp({required bool value, required int index}) {
    listCheckBoxApp[index] = value;
  }

  void updateListCheckboxEmail({required bool value, required int index}) {
    listCheckBoxEmail[index] = value;
  }

  Future<void> editNotification() async {
    isLoading(true);
    try {
      Map<String, dynamic> data = {
        "notification": {
          "locationAsk": {
            "app": listCheckBoxApp[0],
            "SMS": true,
            "mail": listCheckBoxEmail[0]
          },
          "rentConfirmation": {
            "app": listCheckBoxApp[1],
            "SMS": true,
            "mail": listCheckBoxEmail[1]
          },
          "message": {
            "app": listCheckBoxApp[2],
            "SMS": false,
            "mail": listCheckBoxEmail[2]
          },
          "rentAbort": {
            "app": listCheckBoxApp[3],
            "SMS": true,
            "mail": listCheckBoxEmail[3]
          },
          "contract": {
            "app": listCheckBoxApp[4],
            "SMS": true,
            "mail": listCheckBoxEmail[4]
          },
          "pay": {
            "app": listCheckBoxApp[5],
            "SMS": false,
            "mail": listCheckBoxEmail[5]
          }
        }
      };
      user.value = await repository.editNotification(data: data);
      Get.snackbar('Mise à jour', "Enregistré avec succés",
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.secondaryColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 3));
      isLoading(false);
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.redColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 3));
      isLoading(false);
    }
  }
}
