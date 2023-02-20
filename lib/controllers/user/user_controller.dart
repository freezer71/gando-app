


import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

import '../../config/constants.dart';
import '../../models/User.dart';
import '../../models/UserCar.dart';
import '../../services/auth/get_user_car.dart';
import '../../services/provider/api_provider.dart';

class UserController extends GetxController {

  late final Future getCarList;

  //get user carlist
  final userCarList = <UserCar>[].obs;

  final userID = ''.obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    getCarList = getUserCarList();
    super.onInit();
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
      final cars = await CarService().fetchUserCarList();

      if(cars.isNotEmpty) {
        return cars;
      }

      return [];

    } catch (e) {
      Get.snackbar('Error', e.toString(),snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 5));
    }finally{
      isLoading(false);
    }
  }

  void fetchCars() async {
    try {
      isLoading(true);
      var cars = await CarService().fetchUserCarList();
      userCarList.assignAll(cars);
    } finally {
      isLoading(false);
    }
  }

}