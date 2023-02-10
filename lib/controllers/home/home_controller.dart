


import 'package:gando/config/constants.dart';
import 'package:gando/services/provider/api_provider.dart';
import 'package:get/get.dart';

import '../../models/Car.dart';

class HomeController extends GetxController{

  final RxBool isLoading = false.obs;

  final RxList<Car> productDataList = <Car>[].obs;

  @override
  Future onReady() async{
    super.onReady();
    await loadProduct();
  }

  Future loadProduct() async{
    try{
      isLoading(true);
      final res = await  ApiProvider().dioConnect('/voiture/getAll', {});
      final body = res.data;
      if(res.statusCode == STATUS_OK){
        printInfo(info: '$body');
      }
    }catch(e){
      rethrow;
    }finally{
      isLoading(false);
    }
  }
}