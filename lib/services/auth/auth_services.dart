
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
    if(box.hasData('token') && box.read('token') != null){
      box.write('authenticated', true);
      if(box.read('authenticated')) {
        isLoggedIn(true);
      }
    }
  }

  Future<void> handleSignOut() async => await GoogleSignIn().signOut();

  //authenticate user global function
  Future<void> authentication({token, user}) async{
    try{
      await box.write('token', token).then((value) async {
        await box.write('authenticated', true);
        isLoggedIn(true);
        printInfo(info: 'User is authenticated');
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
    Get.offAllNamed(Routes.signIn);
    printInfo(info: 'User is logged out');
  }

  void setIsPremium(bool newValue) {
    isLoggedIn.value = newValue;
  }
}
