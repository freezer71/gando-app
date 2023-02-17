

import 'package:gando/services/provider/init_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingService extends GetxService{
  Future<OnboardingService> init() async => this;

  final box = GetStorage();
  final isFirstOpen = false.obs;

  @override
  void onReady() {

    if(box.hasData('onboarding') && box.read('onboarding') != null){
      if(box.read('onboarding')) {
        isFirstOpen(true);
      }
    }
    printInfo(info : 'Onboarding is $isFirstOpen');
    super.onReady();
  }
}