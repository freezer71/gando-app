import 'package:flutter/material.dart';
import 'package:gando/config/constants.dart';
import 'package:gando/services/provider/api_provider.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{

  final terms = false.obs;
  final isLoading = false.obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;


  @override
  void onReady() {
    super.onReady();
  }

  Future register(data) async{
    try{
      isLoading(true);
      final res = await ApiProvider().dioConnect('$API_URL/authentication/signUp', data);
      final body =  res.data;

      if(res.statusCode == STATUS_OK){
        body['data'];
      }
    }catch(e){
      rethrow;
    }finally{
      isLoading(false);
    }
  }

}