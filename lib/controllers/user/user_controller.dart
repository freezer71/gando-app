


import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../config/constants.dart';
import '../../models/Car.dart';
import '../../models/User.dart';
import '../../models/UserCar.dart';
import '../../services/auth/get_user_car.dart';
import '../../services/provider/api_provider.dart';

class UserController extends GetxController {

  late final Future getCarList;
  late final Future<User> getUserProfile;

  //get user carlist
  final RxList<Car> userCarList = <Car>[].obs;

  final Rx<User> user = User().obs;

  final userID = ''.obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCarList = getUserCarList();
    // check called route name and get user id
    getUserProfile = getUser();
  }

  @override
  void onClose() {
    userCarList.clear();
    getCarList.ignore();
    getUserProfile.ignore();
    super.onClose();
  }


  // get user profil
  Future<User> getUser() async {
    try {
      isLoading(true);
      final res = await ApiProvider().getData('/user');
      final body = jsonDecode(res.body)['data'];

      printInfo(info: "USER DAZTA ========>  : ${body}");

      if (res.statusCode == 200) {
        return user(User.fromJson(body));
      }else{
        return user(User());
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.only(bottom: 20,), duration: const Duration(seconds: 10));
      return User();
    } finally {
      isLoading(false);
    }
  }

  // get user from api
  Future getUserCarList() async {
    try {
      isLoading(true);
      userCarList.value = await CarService().fetchUserCarList();

      if(userCarList.isNotEmpty) {
        return userCarList;
      }else{
        return <Car>[];
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 5));
    }finally{
      isLoading(false);
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

}