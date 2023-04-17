import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/services/auth/auth_services.dart';
import 'package:gando/services/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:gando/models/User.dart' as client;

class WalletController extends GetxController {
  Rx<TextEditingController> ibanControllerField = TextEditingController().obs;
  Rx<TextEditingController> codeBic = TextEditingController().obs;
  WebViewController controllerWebView = WebViewController();
  final UserRepository repository = GetIt.instance.get<UserRepository>();
  Rx<client.User> user = Get.find<AuthService>().user;
  String? url = '';
  RxBool isLoading = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  void initControllerWebView() {
    isLoading(true);
    controllerWebView = controllerWebView
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            isLoading(false);
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url
                .startsWith("https://mygando.com/onboarding/success")) {
              Get.back();
              Get.back();
              Get.back();
            } else if (request.url
                .startsWith("https://mygando.com/onboarding/refresh")) {
              Get.back();
              Get.snackbar(
                  'Vérification identité', "Status annulé par l'utilisateur.",
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: AppTheme.redColor,
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  duration: const Duration(seconds: 3));
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          print("message erreur $message");
        },
      )
      ..loadRequest(Uri.parse(url!));
  }
}
