

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/constants.dart';
import 'package:gando/services/provider/api_provider.dart';
import 'package:get/get.dart';

import '../models/Car.dart';

class CarController extends GetxController {

  CarController({this.id});

  late final id;

  final carId = ''.obs;

  late final Future futureGetCar;
  late final Future<Car> futureGetCarById;

  /// initialize loading
  final RxBool isLoading = false.obs;
  final Rx<TextEditingController> reportController = TextEditingController().obs;

  // is report button active
  final RxBool isReportActive = false.obs;

  // is report formkey
  final GlobalKey<FormState> reportFormKey = GlobalKey<FormState>();

  // init car List
  late RxList<Car> carList = <Car>[].obs;

  late Rx<Car> car = Car().obs;

  // cancel token
  final cancelToken = CancelToken();

  @override
  void onInit() {
    super.onInit();
    futureGetCar = getAllCar();
  }

  @override
  void onClose() {
    cancelToken.cancel();
    carList.clear();
    reportFormKey.currentState?.dispose();
    reportController.value.dispose();

    super.onClose();
  }

  Future reportCar(String id, message) async {
    try {
      isLoading(true);
      final data = {
        "carId": id.toString(),
        "description": message.toString(),
      };
      final res = await ApiProvider().dioConnect('/report/car', data);

      if (res.statusCode == STATUS_OK) {
        Get.snackbar('Success', 'Annonce reported');
      }
    } catch (e) {
      printError(info: e.toString());
      Get.snackbar('Error', e.toString());
    }finally{
      isLoading(false);
    }
  }

  Future getAnnonceByLocation(double lat, double long, int range) async {
    try {
      isLoading(true);
      final res = await ApiProvider().getData('/annonce/all?lat=$lat&long=$long&range=$range');
      final body = jsonDecode(res.body)['data'];

      if (res.statusCode == STATUS_OK) {
        carList.clear();
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

  // load car from api
  Future<List<Car>> getAllCar() async {
    const lat = -61.74436024;
    const long = 16.01911314;
    const range = 100000;

    try {
      isLoading(true);

      final res = await ApiProvider().getData('/annonce/all?lat=$lat&long=$long&range=$range');
      final body = jsonDecode(res.body)['data'];

      // printInfo(info: "CAR DATA ========> : ${body}");

      if (res.statusCode == STATUS_OK) {
        carList.addAll(body.map<Car>((e) => Car.fromJson(e)).toList());
        return carList;
      }

      return [];

    } catch (e) {
      printError(info: e.toString());
      Get.snackbar('Error', e.toString());
      return [];
    }finally{
      isLoading(false);
    }

  }

  // get unique car by id from api
  Future<Car> getCarById(id) async {
    try {
      isLoading(true);

      final res = await ApiProvider().getData('/annonce?carId=${id}');
      final body = jsonDecode(res.body)['data'];

      if (res.statusCode == STATUS_OK) {
        car.value = Car.fromJson(body);
        return car.value;
      }
      return car.value = Car();
    } catch (e) {
      printError(info: e.toString());
      Get.snackbar('Error', e.toString());
      return car.value = Car();
    }finally{
      isLoading(false);
    }
  }

}