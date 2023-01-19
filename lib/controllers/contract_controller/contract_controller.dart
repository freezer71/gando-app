


import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

class ContractController extends GetxController{

  final carCheck= false.obs;
  final assurance = false.obs;
  final grayCard = false.obs;
  final RxDouble carState = 40.0.obs;
  final selectedCarState = ''.obs;
  final annotationValue = '100'.obs;

  final Rx<SignatureController> signature1 = SignatureController(
    penStrokeWidth: 3.0,
    penColor: AppTheme.darkColor,
    exportBackgroundColor: AppTheme.backgroundColor,
  ).obs;

  final Rx<SignatureController> signature2 = SignatureController(
    penStrokeWidth: 3.0,
    penColor: AppTheme.darkColor,
    exportBackgroundColor: AppTheme.backgroundColor,
  ).obs;

  RxList conditionListChecker = [
    'le locataire doit confirmer la certification du controle technique ',
    'le locataire doit confirmer la certification de l\'atesttation d\'assurance ',
    'le locataire doit confirmer la certification de la carte grise ',
  ].obs;

  final listRangeStateCar = [
    'Mauvais',
    'Médiocre',
    'Moyen',
    'Bon',
    'Très propre',
  ];

  final List<String> imagesList = [
    '3/4 Avant','Latéral','3/4 Arrière','Interieur','Suplémentaire'
  ];

  final RxString selectedKilometer = ''.obs;

  final List<String> itemsKilometer = [
    '0-50 000 Km',
    '50-100 000 Km',
    '100 000-150 000 Km',
    '150 000-200 000 Km',
    '+200 000 Km',
  ];

  Rx<TextEditingController> idController = TextEditingController().obs;
  Rx<TextEditingController> dateController = TextEditingController().obs;
  Rx<TextEditingController> country = TextEditingController().obs;

  @override
  void onClose() {
    signature1.close();
    signature2.close();
    super.onClose();
  }

}