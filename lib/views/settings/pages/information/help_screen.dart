import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/config/tools.dart';
import 'package:gando/controllers/user/information_controller.dart';
import 'package:gando/widget/appBarWidget.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HelpScreen extends GetView<InformationController> {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
            Get.back();
            Utils.closeLoadingDialog();
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: AppTheme.darkColor,
          ),
        ),
        title: "Centre d'aide",
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Container(
              width: Get.width,
              height: Get.height,
              color: AppTheme.backgroundColor,
              child: Center(
                child: Text(
                  "Chargement de la page...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppTheme.darkColor),
                ),
              ),
            );
          }
          return WebViewWidget(controller: controller.controllerWebViewHelp);
        },
      ),
    );
  }
}
