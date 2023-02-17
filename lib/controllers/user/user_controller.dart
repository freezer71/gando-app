


import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

import '../../config/constants.dart';
import '../../models/User.dart';
import '../../models/UserCar.dart';
import '../../services/provider/api_provider.dart';

class UserController extends GetxController {

  //get user carlist
  final RxList<UserCar> userCarList = <UserCar>[].obs;

  final userID = ''.obs;

  final isLoading = false.obs;

  @override
  void onReady() {
    getUserCarList();
    super.onReady();
  }

  @override
  void onClose() {
    userCarList.clear();
    super.onClose();
  }


  // get user from api
  Future getUserCarList() async {
    try {
      isLoading(true);
      await ApiProvider().getData('/user').then((value) {
        final body = jsonDecode(value.body)['data'];
        userID.value = body['_id'];
        return User.fromJson(body);
      });

      final res = await ApiProvider().getData('/car/getUserCars?userId=$userID');
      final body = jsonDecode(res.body)['data'];

      if (res.statusCode == STATUS_OK) {

        userCarList.clear();
        final tt = body.map((e) => e).toList();
        // final data = body.map<UserCar>((e) => userCarFromJson(e)).toList();
        // userCarList.addAll(body.map<UserCar>((e) => userCarFromJson(e)).toList());
        // final datas = userCar;FromJson(jsonDecode(body));
        printInfo(info: '${jsonEncode(tt)}');
        // userCarList.assignAll(body.map<UserCar>((e) => UserCar.fromJson(e)).toList());
        // userCarList.addAll(data);
      }
    } catch (e) {
      printError(info: e.toString());
      Get.snackbar('Error', e.toString(), duration: Duration(seconds: 5));
    }finally{
      isLoading(false);
    }
  }



}