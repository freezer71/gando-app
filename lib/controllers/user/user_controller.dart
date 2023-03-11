


import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

import '../../config/constants.dart';
import '../../models/Car.dart';
import '../../models/User.dart';
import '../../models/UserCar.dart';
import '../../services/auth/get_user_car.dart';
import '../../services/provider/api_provider.dart';

class UserController extends GetxController {

  late final Future getCarList;

  //get user carlist
  final RxList<Car> userCarList = <Car>[].obs;

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
    getCarList.ignore();
    super.onClose();
  }

  // get user from api
  Future getUserCarList() async {
    try {
      isLoading(true);
      userCarList.value = await CarService().fetchUserCarList();

      if(userCarList.isNotEmpty) {
        return userCarList;
      }else{
        return [];
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