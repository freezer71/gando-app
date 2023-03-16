

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
  late RxList<Car> carList = <Car>[].obs;

  late Rx<Car> car = Car().obs;

  // cancel token
  final cancelToken = CancelToken();

  @override
  void onReady() {
    getAllCar();
    super.onReady();
  }

  @override
  void onClose() {
    cancelToken.cancel();
    carList.clear();
    super.onClose();
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
  Future getAllCar() async {
    const lat = 43.774483;
    const long = 7.49754;
    const range = 50;

    try {
      isLoading(true);

      final res = await ApiProvider().getData('/annonce/all?lat=$lat&long=$long&range=$range');
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

  // get unique car by id from api
  Future getCarById(String id) async {
    try {
      isLoading(true);

      final res = await ApiProvider().getData('/annonce/?carId=640b5d0c4605806ae6fc0cf5');
      final body = jsonDecode(res.body)['data'];

      if (res.statusCode == STATUS_OK) {
         return car = body.map<Car>((e) => Car.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load car');
      }
    } catch (e) {
      printError(info: e.toString());
      Get.snackbar('Error', e.toString());
    }finally{
      isLoading(false);
    }
  }


}