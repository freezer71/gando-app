


import 'package:get/get.dart';

import '../controllers/car_controller.dart';
import '../services/auth/auth_services.dart';
import '../services/onboarding_services.dart';

class InitBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(
          () => AuthService(),
    );
    Get.lazyPut<OnboardingService>(
          () => OnboardingService(),
    );
    // init car controller
    Get.lazyPut<CarController>(
          () => CarController(),
    );
  }
}