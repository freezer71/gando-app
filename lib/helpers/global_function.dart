

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

import '../config/textstyle.dart';

class GlobalFunction {
  final box = GetStorage();

  void showSnackbar({msg}) {
    Get.snackbar(msg != null && msg.isNotEmpty ? "Notification": "otp_auth".tr, msg.isNotEmpty ? msg : "invalid_access_code".tr,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        duration: const Duration(seconds: 3),
        icon: const Padding(
          padding: EdgeInsets.all(18.0),
          child: Icon(
            Icons.nearby_error,
            color: Colors.red,
            size: 35,
          ),
        ),
        padding: const EdgeInsets.only(left: 22.0, bottom: 12.0, top: 12.0),
        margin: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 28.0));
  }

  void loader(bool value) async{

    // late BuildContext context;

    value ?
    SmartDialog.showLoading(
      animationType: SmartAnimationType.scale,
      maskColor: Colors.black87,
      builder: (_) => Center(
        child: Column(
          children: [
            const Spacer(flex: 1,),
            LottieBuilder.asset("assets/lotties/loader.zip", height: 180, fit: BoxFit.cover,),
            const SizedBox(height: 14,),
            Text("loading".tr, style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),),
            const Spacer(flex: 1,),
          ],
        ),
      ),
    ) :
    SmartDialog.dismiss();
  }

  final defaultPinTheme = PinTheme(
    width: 66,
    height: 66,
    textStyle: TextStyle(
        fontSize: 32,
        color: AppTheme.primaryColor,
        fontWeight: FontWeight.w800),
    decoration: BoxDecoration(
      color: AppTheme.secondaryColor.withOpacity(0.7),
      border: Border.all( color: AppTheme.primaryColor, width: 2.0),
      borderRadius: BorderRadius.circular(16),
    ),
  );

  //currency section

  String removeDecimalZeroFormat(double v) {
    NumberFormat formatter = NumberFormat();
    // function currency converter price by get user country code location
    final format = NumberFormat.simpleCurrency(
      locale: Platform.localeName,
      decimalDigits: 2,
      // locale: 'en_US' ,
    );
    // const fromCurrency = "XAF";
    final toCurrency = format.currencyName;
    final symbol = format.currencySymbol;
    formatter.minimumFractionDigits = 0;
    formatter.maximumFractionDigits = 2;

    if (box.hasData('settings')) {
      final param = box.read('settings')['currency'];
      final rate = v / param['rate'].toDouble();

      switch (toCurrency) {
        case 'EUR':
          final value = rate;
          return  formatter.format(value).replaceAll('.', ',') + " $symbol" ;
        case 'USD':
          final value = rate;
          return '$symbol ' + formatter.format(value).replaceAll(',', '.');
        case 'GPB':
          final value = rate;
          return '$symbol ' + formatter.format(value).replaceAll(',', '.');
        default:
          return formatter.format(v).replaceAll(',', '.') + ' $symbol';
      }
    }

    return formatter.format(v).replaceAll(',', '.') + ' $symbol';
  }
}


