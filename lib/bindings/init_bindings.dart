import 'package:gando/controllers/authController/owner_controller.dart';
import 'package:gando/controllers/chat/chat_controller.dart';
import 'package:gando/controllers/settings_controller/account_setting_controller.dart';
import 'package:gando/controllers/user/edit_profile_controller.dart';
import 'package:gando/controllers/user/user_controller.dart';
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
    Get.lazyPut<EditProfilController>(() => EditProfilController());
    Get.lazyPut<OwnerController>(() => OwnerController());
    Get.lazyPut<AccountSettingController>(() => AccountSettingController());
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<ChatController>(() => ChatController());
  }
}
