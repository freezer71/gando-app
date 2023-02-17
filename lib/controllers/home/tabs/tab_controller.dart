import 'package:get/get.dart';

class TabScreenController extends GetxController{
  RxInt pageIndex = 0.obs;
  RxInt i = 0.obs;
  RxBool isVisible = false.obs;

  RxList pageTextList = ['Home', 'Statistics', 'Card', 'Profile'].obs;

  customInit() {
    pageIndex.value = 0;
  }
}