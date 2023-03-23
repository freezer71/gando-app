
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../navigation.dart';


class AuthService extends GetxService {
  Future<AuthService> init() async => this;

  final RxBool isLoggedIn = false.obs;
  final GetStorage box = GetStorage();

  @override
  void onReady() async {
    super.onReady();
    // check onboarding status
    if(box.hasData('onboarding') && box.read('onboarding') != null){
      if(box.read('onboarding')) {
        //check authentication status
        if(box.hasData('token') && box.read('token') != null){
          box.write('authenticated', true);
          if(box.read('authenticated')) {
            isLoggedIn(true);
            printInfo(info: 'AuthService is ready');
            printInfo(info: 'User is authenticated : ${box.read('authenticated')}');
            printInfo(info: 'User token : ${box.read('token')}');
          }
        }else{
          await logout();
        }
      }else{
        printInfo(info: 'User has not seen onboarding');
        Get.offAllNamed(Routes.welcome);
      }
    }else{
      box.writeIfNull('onboarding', false);
      printInfo(info: 'User has not seen onboarding');
      Get.offAllNamed(Routes.welcome);
    }
  }

  Future<void> handleSignOut() async => await GoogleSignIn().signOut();

  //authenticate user global function
  Future<void> authentication({token}) async{
    try{
      await box.write('token', token).then((value) async {
        await box.write('authenticated', true);
        isLoggedIn(true);
        printInfo(info: 'User is authenticated'.toLowerCase());
      });
    }catch(e) {
      rethrow;
    }
  }

  Future<void> logout() async{
    await box.remove('token');
    await box.remove('authenticated');
    await handleSignOut();
    isLoggedIn(false);
    Get.offAllNamed(Routes.preLogin);
    printInfo(info: 'User is logged out');
  }

  void setIsPremium(bool newValue) {
    isLoggedIn.value = newValue;
  }
}

