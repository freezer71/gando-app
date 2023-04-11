

import 'package:gando/services/provider/init_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'auth/auth_services.dart';

class OnboardingService extends GetxService{
  Future<OnboardingService> init() async => this;

  final box = GetStorage();
  final isFirstOpen = true.obs;
  static OnboardingService get to => Get.find();

  @override
  void onReady() {
    super.onReady();
    if(box.hasData('onboarding') && box.read('onboarding') != null) {
      if (box.read('onboarding') == false) {
        isFirstOpen(false);
      }
    }else{
      box.write('onboarding', true);
    }
  }

  Future<void> setOnboarding() async {
    await box.write('onboarding', false);
    isFirstOpen(false);
  }

  @override
  void onClose() {
    isFirstOpen(true);
    super.onClose();
  }
}