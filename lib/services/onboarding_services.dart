

import 'package:gando/services/provider/init_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingServices extends GetxService{

  final box = GetStorage();
  final isFirstOpen = false.obs;

  @override
  void onReady() {
    super.onReady();
    isFirstOpen.value = box.read('onboarding') ?? false;
  }
}