import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
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
            },
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: AppTheme.darkColor,
            ),
          ),
          title: 'Verification Identity',
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Container(
                color: AppTheme.redColor,
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: AppTheme.primaryColor,
                  strokeWidth: 5.0,
                ));
          }
          return WebViewWidget(controller: controller.controllerWebView);
        }));
  }
}
