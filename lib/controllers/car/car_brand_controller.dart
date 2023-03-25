
import 'dart:convert';

import 'package:gando/config/constants.dart';
import 'package:gando/services/auth/get_user_car.dart';
import 'package:gando/services/provider/api_provider.dart';
import 'package:get/get.dart';
import 'package:gando/models/CarBrandModel.dart';


class CarBrandController extends GetxController {

  final _carBrandList = <CarBrand>[].obs;
  List<CarBrand> get carBrandList => _carBrandList;

  late final Future futureGetCarBrands;

  final selectedBrand = "".obs;
  final selectedModel = "".obs;
  final brands = <CarBrand>[].obs;

  @override
  void onInit() {
    super.onInit();
    futureGetCarBrands = getCarBrands();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<List<CarBrand>> getCarBrands() async {
    try {
      final response = await ApiProvider().getData('/utils/carMarque');
      final body = jsonDecode(response.body)['data'];

      if (response.statusCode == STATUS_OK) {
        final carBrands = body.map<CarBrand>((json) => CarBrand.fromJson(json)).toList();
        _carBrandList.assignAll(carBrands);
        printInfo(info: 'CAR BRANDS ========>  : ${carBrandList.first.toJson()}');
        return carBrandList;
      }
      return <CarBrand>[];
    } catch (e) {
      print(e);
      Get.snackbar('Error', e.toString(),snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 5));
      return <CarBrand>[];
    }
  }

  List<String> getBrandNames(List<CarBrand> data) {
    return data.map((brand) => brand.name).toList();
  }

  List<String> getModelNames(List<CarBrand> data) {
    final brand = data.firstWhere((brand) => brand.name == selectedBrand.value);
    return brand.models.map((model) => model.name).toList();
  }
}