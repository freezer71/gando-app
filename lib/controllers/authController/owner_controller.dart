import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/user/user_controller.dart';
import 'package:gando/services/provider/api_provider.dart';
import 'package:gando/services/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/User.dart' as client;

class OwnerController extends GetxController {
  final UserRepository repository = GetIt.instance.get<UserRepository>();
  final Rx<bool> isLoading = false.obs;
  UserController userController = Get.put(UserController());
  String? idUser;
  late Rx<client.User> user = client.User().obs;

  set setUser(client.User v) {
    user.value = v;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    idUser = userController.user.value.id;
    // idUser = userController.user.value.id!;
  }

  //edit first name, lastname and description
  Future<void> verifyOwner() async {
    isLoading(true);

    try {
      Map<String, dynamic> data = {"id": user.value.id};
      // await Future.delayed(Duration(seconds: 5));
      await repository.verifyOwner(data: data);
      Get.snackbar('Mise à jour', "Enregistré avec succés",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppTheme.secondaryColor,
          margin: const EdgeInsets.only(
            bottom: 20,
          ),
          duration: const Duration(seconds: 5));
      isLoading(false);
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(
            bottom: 20,
          ),
          duration: const Duration(seconds: 10));
      isLoading(false);
    }
  }

  // get user profil
  Future<client.User> getUser() async {
    try {
      isLoading(true);
      final res = await ApiProvider().getData('/user');
      final body = jsonDecode(res.body)['data'];

      printInfo(info: "USER DAZTA ========>  : ${body}");

      if (res.statusCode == 200) {
        idUser = body["_id"];
        print("atooo ${body["_id"]}");
        setUser = client.User.fromJson(body);
        return user(client.User.fromJson(body));
      } else {
        return user(client.User());
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(
            bottom: 20,
          ),
          duration: const Duration(seconds: 10));
      return client.User();
    } finally {
      isLoading(false);
    }
  }
}
