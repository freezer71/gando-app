



import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../config/constants.dart';
import '../../models/Car.dart';
import '../../models/Equipment.dart';
import '../../services/provider/api_provider.dart';

class EditArticleController extends GetxController{

  EditArticleController({this.id});

  late final id;

  final carId = ''.obs;

  final RxBool isLoading = false.obs;

  late final Future futureGetCar;

  late Car car;

  Rx<TextEditingController> addressController = TextEditingController().obs;

  Rx<TextEditingController> descriptionController = TextEditingController(text: """
    lorem ipsum lorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsum
    lorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsum
  """).obs;


  Rx<TextEditingController> kilometerController = TextEditingController().obs;
  Rx<TextEditingController> dayPrice = TextEditingController(text: '').obs;
  Rx<TextEditingController> weekPrice = TextEditingController(text: '').obs;
  Rx<TextEditingController> monthPrice = TextEditingController(text: '').obs;

  final List<String> itemsKilometer = [
    '0-50 000 Km',
    '50-100 000 Km',
    '100 000-150 000 Km',
    '150 000-200 000 Km',
    '+200 000 Km',
  ];

  static List<Equipment> equipmentsList = [
    Equipment(1, 'Climatisation'),
    Equipment(2, 'Régulateur de vitesse'),
    Equipment(3, 'GPS'),
    Equipment(4, 'Siège enfant'),
    Equipment(5, 'bluetooth'),
    Equipment(6, 'Pneus Neige'),
    Equipment(7, 'Caméra de recule'),
  ];

  final items = equipmentsList
      .map((data) => MultiSelectItem<Equipment>(data, data.name))
      .toList();

  List<Equipment> selectedEquipments = [];

  final _multiSelectKey = GlobalKey<FormFieldState>();

  final RxString selectedKilometer = ''.obs;
  final RxBool youngDriver = false.obs;
  String? selectedEquipment;

  // ready
  @override
  void onInit() {
    super.onInit();
    carId.value = id;
    futureGetCar = getAnnonceById(carId.value);
  }


  @override
  void dispose() {
    descriptionController.close();
    addressController.close();
    super.dispose();
  }

  Future<Car> getAnnonceById(carId) async {
    isLoading(true);
    try {
      final res = await ApiProvider().getData('/annonce?carId=$carId');
      final body = jsonDecode(res.body)['data'];

      if (res.statusCode == STATUS_OK) {
        car = Car.fromJson(body);
        printInfo(info: car.toJson().toString());
        // init value
        addressController.value.text = car.address!;
        descriptionController.value.text = car.description!;
        // selectedKilometer.value = car.mileage!;
        youngDriver.value = car.youngDriver!;
        printInfo(info: car.equipment!.toString());
        // selectedEquipments.addAll(car.equipment!.map((e, index) => Equipment(index, e)).toList());
        // kilometerController.text = car.mileage!;
        dayPrice.value.text = car.pricePerDay!.toString();
        weekPrice.value.text = car.pricePerWeek!.toString();
        monthPrice.value.text = car.pricePerMonth!.toString();

        return car;
      }
      return Car();
    } catch (e) {
      printError(info: e.toString());
      Get.snackbar('Error', e.toString());
      return Car();
    } finally {
      isLoading(false);
    }
  }


  // edit car
  Future editCar() async {
    try {
      isLoading(true);
      final res = await ApiProvider().putData('/annonce', {
        'carId': carId.value,
        'address': addressController.value.text,
        'description': descriptionController.value.text,
        'mileage': selectedKilometer.value,
        'youngDriver': youngDriver.value,
        'equipment': selectedEquipments.map((e) => e.name).toList(),
        'pricePerDay': dayPrice.value.text,
        'pricePerWeek': weekPrice.value.text,
        'pricePerMonth': monthPrice.value.text,
      });
      final body = res.data;

      if (res.statusCode == STATUS_OK) {
        Get.snackbar('Success', 'Car edited successfully');
        Get.back();
      }
    } catch (e) {
      printError(info: e.toString());
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}