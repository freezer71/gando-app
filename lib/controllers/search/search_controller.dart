import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchController extends GetxController{

  final priceCheckbox = false.obs;
  final priceMin = TextEditingController().obs;
  final priceMax = TextEditingController().obs;

  final List carTypeList = [
    {'title': 'Cabriolet'},
    {'title': 'Minibus'},
    {'title': '4x4'},
    {'title': 'Familiale'},
    {'title': 'Coupé'},
    {'title': 'Berline'},
    {'title': 'utilitaire'},
    {'title': 'Citadine'},
    {'title': 'Autre(s)'},
  ];

  final List speedBox = [
    {'title': 'Automatique'},
    {'title': 'Manuelle'},
  ];

  RxInt selectedPlaces = 2.obs;
  RxInt selectedDoor = 0.obs;
  RxString selectedType = ''.obs;
  RxString selectedFuel = ''.obs;

  final List fuelList = [
    {'title': 'Essence'},
    {'title': 'Diesel'},
    {'title': 'Hybride'},
    {'title': 'Electrique'},
    {'title': 'Autre(s)'},
  ];

  final List<int> placesList = [
    2,3,4,5,6,7,8,9
  ];

  final List<int> doorList = [
    2,3,4,5,6,7,
  ];

  final RxBool gearBox = false.obs;
  final RxBool togglePrice = false.obs;
  final RxBool youngDriver = false.obs;

  Rx<TextEditingController> minYearController = TextEditingController().obs;
  Rx<TextEditingController> maxYearController = TextEditingController().obs;

}