import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/config/tools.dart';
import 'package:gando/controllers/user/user_controller.dart';
import 'package:gando/navigation.dart';
import 'package:gando/services/auth/auth_services.dart';
import 'package:gando/services/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../models/User.dart' as client;

class EditProfilController extends GetxController {
  TextEditingController firstNameController =
      TextEditingController(text: Get.find<AuthService>().user.value.firstname);
  TextEditingController lastNameController =
      TextEditingController(text: Get.find<AuthService>().user.value.lastname);
  TextEditingController descriptionController = TextEditingController(
      text: Get.find<AuthService>().user.value.description);
  Rx<int> numberTextDescription = 0.obs;
  Rx<client.User> user = Get.find<AuthService>().user;
  final Rx<bool> isLoading = false.obs;
  final Rx<bool> isSuccess = false.obs;
  final UserRepository repository = GetIt.instance.get<UserRepository>();

  //edit first name, lastname and description
  Future<void> editNameAndDescription() async {
    isLoading(true);
    String description =
        descriptionController.text.isEmpty ? " " : descriptionController.text;
    try {
      Map<String, dynamic> data = {
        "firstname": firstNameController.text,
        "lastname": lastNameController.text,
        "description": description,
      };
      user.value = await repository.editNameAndDescription(data: data);
      Get.snackbar('Mise à jour', "Enregistré avec succés",
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.secondaryColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 3));
      isSuccess(true);
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 3));
    } finally {
      isLoading(false);
    }
  }

  //upload file profile picture in server file
  Future<void> uploadProfilePicture({required File file}) async {
    Utils.showLoadingDialog();
    try {
      String fileName = await repository.uploadSingleFile(file: file);
      await editProfilePicture(fileName: fileName);
      Utils.closeLoadingDialog();
      Get.snackbar('Mise à jour', "Modification photo de profil avec succés",
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.secondaryColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 3));
    } catch (e) {
      Utils.closeLoadingDialog();
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.redColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 3));
    }
  }

  //edit profile picture
  Future<client.User> editProfilePicture({required String fileName}) async {
    try {
      Map<String, dynamic> data = {
        "picture": fileName,
      };
      client.User _user = await repository.editProfilePicture(data: data);
      user.value = _user;
      return _user;
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 10));
      return client.User();
    }
  }
}
