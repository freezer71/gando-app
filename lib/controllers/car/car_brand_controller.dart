
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
        selectedBrand.value = carBrandList.first.name;
        selectedModel.value = carBrandList.first.models.first.name;
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
    if(data.isNotEmpty) {
      return data.map((brand) => brand.name.toString()).toList();
    }else{
      return <String>[
        'No data brand'
      ];
    }
  }

  List<String> getModelNames() {
    if (selectedBrand.value.isNotEmpty) {
      final brand = carBrandList.firstWhere((brand) => brand.name == selectedBrand.value);
      final model = brand.models.map((model) => model.name.toString()).toList();
      return model;
    }else{
      return <String>[
        'No data model'
      ];
    }
  }

  void changeBrand(String value) {
    selectedBrand(value);
    selectedModel.value = carBrandList.firstWhere((brand) => brand.name == selectedBrand.value).models.first.name;
    update();
  }

  void changeModel(String value) {
    selectedModel(value);
    update();
  }
}