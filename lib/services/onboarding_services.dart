

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingServices extends GetxService{

  final box = GetStorage();
  final isFirst = false.obs;

  @override
  void onReady() {
    box.hasData('onboarding') || box.read('onboarding') ? isFirst(true) : isFirst(false);
    super.onReady();
  }
}