

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../models/Equipment.dart';

class AddArticlesController extends GetxController {
  var currentStep = 0.obs;

  //---------- step 1 -------------//
  Rx<TextEditingController> brandController = TextEditingController().obs;
  Rx<TextEditingController> modelController = TextEditingController().obs;
  Rx<TextEditingController> typeController = TextEditingController().obs;
  Rx<TextEditingController> distanceController = TextEditingController().obs;
  Rx<TextEditingController> numberplateController = TextEditingController().obs;
  Rx<TextEditingController> fuelController = TextEditingController().obs;
  RxString yearController = ''.obs;

  final List<String> itemsKilometer = [
    '0-50 000 Km',
    '50-100 000 Km',
    '100 000-150 000 Km',
    '150 000-200 000 Km',
    '+200 000 Km',
  ];

  final List<Equipment> equipmentsList = [
    Equipment(1, 'Climatisation'),
    Equipment(2, 'Régulateur de vitesse'),
    Equipment(3, 'GPS'),
    Equipment(4, 'Siège enfant'),
    Equipment(5, 'bluetooth'),
    Equipment(6, 'Pneus Neige'),
    Equipment(7, 'Caméra de recule'),
    Equipment(8, 'Radio'),
  ];

  final List<int> placesList = [
    2,3,4,5,6,7,8,9
  ];

  final List<int> doorList = [
    2,3,4,5,6,7,
  ];

  final RxList<MultiSelectItem> items = <MultiSelectItem>[].obs;
  RxList<Equipment> selectedEquipments = <Equipment>[].obs;

  final RxString selectedKilometer = ''.obs;
  RxBool gearboxValue = false.obs;
  RxInt selectedPlaces = 2.obs;
  RxInt selectedDoor = 0.obs;
  RxString selectedGearbox = ''.obs;
  // ---- step 1 -----------------//

  // ------------- step 2 ---------//
  final List<String> imagesList = [
    '3/4 Avant','Latéral','3/4 Arrière','Interieur','Suplémentaire'
  ];
  //-------------- step 2 --------------//

  // ------------- step 3 -------------//
  Rx<TextEditingController> descriptionController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> cityController = TextEditingController().obs;
  Rx<TextEditingController> postalCodeController = TextEditingController().obs;
  // ------------- step 3 -------------//

  //---------- step 4 ----------------//
  final initialDate = DateTime.now().obs;
  final initialDateRange = DateTimeRange(
      start: DateTime.now(), end: DateTime.now()).obs;
  //------------Step 4 --------------//


  //----------Final step -----------//
  RxBool youngDriver = false.obs;
  Rx<TextEditingController> dayPriceController = TextEditingController(text: '30').obs;
  Rx<TextEditingController> weekPriceController = TextEditingController(text: '160').obs;
  Rx<TextEditingController> monthPriceController = TextEditingController(text: '400').obs;
  //----------Final step -----------//

  @override
  void onInit() {
    items.value = equipmentsList
        .map((data) => MultiSelectItem<Equipment>(data, data.name))
        .toList();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}