import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:gando/services/navigation_service.dart';
import 'package:gando/widget/loading_dialog.dart';
import 'package:get/get.dart';

class Utils {
  static showLoadingDialog() {
    return Get.dialog(
      LoadingDialog(),
      barrierDismissible: false,
      navigatorKey: NavigationService.navigatorKey,
    );
  }

  static closeLoadingDialog() {
    if (Get.isDialogOpen!) Get.back();
  }

  static Future<bool> checkConnexion() async {
    if (kIsWeb) {
      // TODO: find ways to check if internet is connected,
      // for now we assume use is online that's why he got access to web
      // window.addEventListener('online', () => console.log('came online'));
      // window.addEventListener('offline', () => console.log('came offline'));
      return true;
    }
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // do the operation for connected, or change the bool to True for connected
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
