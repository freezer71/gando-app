import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/constants.dart';
import 'package:gando/navigation.dart';
import 'package:gando/services/auth/auth_services.dart';
import 'package:gando/services/navigation_service.dart';
import 'package:gando/services/onboarding_services.dart';
import 'package:gando/translations/locale_string.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gando/di.dart' as di;
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await di.init();
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
      navigatorKey: NavigationService.navigatorKey,
      smartManagement: SmartManagement.onlyBuilder,
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
      locale: Get.deviceLocale,
      supportedLocales: listSupportedtLocale,
      localizationsDelegates: [
        FallbackLocalizationDelegate(),
        //https://stackoverflow.com/questions/70066318/flutterios-no-cupertinolocalizations-found-how-fix-it
        DefaultCupertinoLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ], // <- append here
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

//https://stackoverflow.com/questions/57902361/flutter-app-crashes-building-the-appbar-with-multi-language-using-i18n-jetbrains
class FallbackLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  @override
  bool isSupported(Locale locale) => true;
  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      DefaultMaterialLocalizations();
  @override
  bool shouldReload(_) => false;
}
