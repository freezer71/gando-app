

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gando/config/constants.dart';
import 'package:gando/services/provider/api_provider.dart';
import 'package:get/get.dart';

import '../models/Car.dart';

class CarController extends GetxController {

  /// initialize loading
  final RxBool isLoading = false.obs;

  // init car List
  final RxList<Car> carList = <Car>[].obs;

  // cancel token
  final cancelToken = CancelToken();

  @override
  void onReady() {
    loadCar();
    super.onReady();
  }

  @override
  void onClose() {
    cancelToken.cancel();
    carList.clear();
    super.onClose();
  }

  // load car from api
  Future loadCar() async {
    try {
      isLoading(true);

      final res = await ApiProvider().getData('/car/getAll');
      final body = jsonDecode(res.body)['data'];

      if (res.statusCode == STATUS_OK) {
        carList.addAll(body.map<Car>((e) => Car.fromJson(e)).toList());
        update();
      }
    } catch (e) {
      printError(info: e.toString());
      Get.snackbar('Error', e.toString());
    }finally{
      isLoading(false);
    }

  }
}