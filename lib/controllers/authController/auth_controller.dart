

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final _isPremium = false.obs;
  set setIsPremium(bool newValue) => _isPremium.value = newValue;
  bool get isPremium => _isPremium.value;

  final isLoading = false.obs;
  final box = GetStorage();


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

}