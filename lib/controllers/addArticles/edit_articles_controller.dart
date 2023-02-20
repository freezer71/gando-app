



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../models/Equipment.dart';

class EditArticleController extends GetxController{

  Rx<TextEditingController> addressController = TextEditingController().obs;

  Rx<TextEditingController> descriptionController = TextEditingController(text: """
    lorem ipsum lorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsum
    lorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsum
  """).obs;


  TextEditingController kilometerController = TextEditingController();
  TextEditingController dayPrice = TextEditingController(text: '30');
  TextEditingController weekPrice = TextEditingController(text: '160');
  TextEditingController monthPrice = TextEditingController(text: '400');

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
  void onReady() {
    addressController.value.text = 'address';
    super.onReady();
  }


  @override
  void dispose() {
    descriptionController.close();
    addressController.close();
    super.dispose();
  }
}