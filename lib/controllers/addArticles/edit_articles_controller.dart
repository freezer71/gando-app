



import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditArticleController extends GetxController{
  Rx<TextEditingController> descriptionController = TextEditingController(text: """
    lorem ipsum lorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsum
    lorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsumlorem ipsum
  """).obs;


  @override
  void dispose() {
    descriptionController.close();
    super.dispose();
  }
}