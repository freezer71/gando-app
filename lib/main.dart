import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/car_controller.dart';
import 'package:gando/navigation.dart';
import 'package:gando/services/auth/auth_services.dart';
import 'package:gando/services/chat/chat_service.dart';
import 'package:gando/services/onboarding_services.dart';
import 'package:gando/translations/locale_string.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Get.putAsync(() => OnboardingService().init());
  await Get.putAsync(() => AuthService().init());

  SystemChrome.setSystemUIOverlayStyle(
    Platform.isIOS
        ? SystemUiOverlayStyle.dark
        : const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (_) => runApp(
     const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static setCustomeTheme(BuildContext context, int index) async {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();

    state!.setCustomeTheme(index);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final box = GetStorage();

  // final controller = Get.put(OnboardingServices());

  setCustomeTheme(int index) {
    if (index == 6) {
      setState(() {
        AppTheme.isLightTheme = true;
      });
    } else if (index == 7) {
      setState(() {
        AppTheme.isLightTheme = false;
      });
    }

    box.write('isLightMode', AppTheme.isLightTheme);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: AppTheme.getTheme().primaryColor,
      systemNavigationBarDividerColor: AppTheme.getTheme().disabledColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return GetMaterialApp(
      title: 'Gando',
      smartManagement: SmartManagement.onlyBuilder,
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
      locale: Get.deviceLocale,
      translations: LocaleString(),
      fallbackLocale: Get.fallbackLocale,
      theme: AppTheme.getTheme(),
      debugShowCheckedModeBanner: false,
      getPages: AppPages.appPages,
      // I add my list of pages here
      initialRoute: AppPages
          .INITIAL, // This is the page that should be rendered on app launch
    );
  }
}
