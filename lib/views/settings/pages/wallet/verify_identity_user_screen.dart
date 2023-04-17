import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/config/tools.dart';
import 'package:gando/controllers/wallet/wallet_controller.dart';
import 'package:gando/widget/appBarWidget.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VerifyIdentityUserScreen extends GetView<WalletController> {
  const VerifyIdentityUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
            Get.back();
            Utils.closeLoadingDialog();
            Get.snackbar(
                'Vérification identité', "Status annulé par l'utilisateur.",
                snackPosition: SnackPosition.TOP,
                backgroundColor: AppTheme.redColor,
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                duration: const Duration(seconds: 3));
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: AppTheme.darkColor,
          ),
        ),
        title: 'Verification Identity',
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
          return WebViewWidget(controller: controller.controllerWebView);
        },
      ),
    );
  }
}
