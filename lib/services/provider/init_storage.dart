

import 'package:get_storage/get_storage.dart';

class Storage {
  final box = GetStorage();

  authenticationStart({token}) async {
    try{
      box.write('token', token);
    }catch(e){
      rethrow;
    }
  }




}