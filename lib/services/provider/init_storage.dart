

import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get_storage/get_storage.dart';

class Storage extends GetxService {

  final box = GetStorage();

  authenticationStart({token}) async {
    try{
      box.write('token', token);
    }catch(e){
      rethrow;
    }
  }
}