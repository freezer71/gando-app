import 'package:flutter/material.dart';
import 'package:gando/services/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WalletController extends GetxController {
  Rx<TextEditingController> ibanControllerField = TextEditingController().obs;
  Rx<TextEditingController> codeBic = TextEditingController().obs;
  WebViewController controllerWebView = WebViewController();
  final UserRepository repository = GetIt.instance.get<UserRepository>();
  String userId = "";
  final box = GetStorage();

  RxBool isLoading = false.obs;
  @override
  Future<void> onInit() async {
    await _getUserId();
    await getAccountLinkUrl();
    controllerWebView = controllerWebView
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            isLoading(true);
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
            print("request url ato ${request.url}");
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            if (request.url.startsWith("http://localhost:5500/success.html")) {
              Get.back();
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
          /* ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );*/
        },
      )
      ..loadRequest(Uri.parse('http://localhost:5500/serverTest.html'));
    super.onInit();
  }

  Future<void> _getUserId() async {
    if (box.hasData('userId') && box.read('userId') != null) {
      userId = await box.read('userId');
      printInfo(info: 'userId============> : $userId');
    }
  }

  Future<void> getAccountLinkUrl() async {
    Map<String, dynamic> data = {
      "userId": userId,
    };
    String url = await repository.onBoardingAccount(data: data);
  }
}
