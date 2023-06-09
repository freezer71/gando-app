import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/settings_controller/account_setting_controller.dart';
import 'package:gando/helpers/global_function.dart';
import 'package:gando/navigation.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../controllers/authController/auth_controller.dart';
import '../../../widget/submit_with_loading_button.dart';

class VerifyMailOtpScreen extends GetView<AccountSettingController> {
  VerifyMailOtpScreen({Key? key}) : super(key: key);

  final gf = GlobalFunction();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backwardsCompatibility: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppTheme.darkColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(
        () => InkWell(
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: AppBar().preferredSize.height + 50,
                  ),
                  children: [
                    Hero(
                        tag: 'logo',
                        child: Image.asset('assets/images/gando-logo.png',
                            height: 140)),
                    const SizedBox(
                      height: 35,
                    ),
                    Center(
                      child: Text(
                        "Saisissez le code OTP que vous avez recu par email",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: HexColor(AppTheme.primaryColorString!),
                            ),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Form(
                          //key: controller.forgotPasswordFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              buildInput(context),
                              const SizedBox(
                                height: 60,
                              ),
                              SubmitWithLoadingButton(
                                onPressed: () async {
                                  await controller.verifyMailUser();
                                  if (controller.isSuccess.value) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  }
                                },
                                text: 'Confirmer'.toUpperCase(),
                                isLoading: controller.isLoading.value,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInput(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), border: Border.all()),
      child: Pinput(
        key: Get.keys[10],
        useNativeKeyboard: true,
        validator: (val) {
          if (!gf.isOtp(val!)) {
            return "Code invalide";
          }
          return null;
        },
        keyboardType: TextInputType.number,
        length: 6,
        androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
        controller: controller.pinController.value,
        preFilledWidget: Container(
          width: 12,
          decoration:
              BoxDecoration(color: AppTheme.darkColor, shape: BoxShape.circle),
        ),
        defaultPinTheme: gf.myDefaultPinTheme,
        onCompleted: (pin) {},
        focusedPinTheme: gf.myDefaultPinTheme,
        showCursor: false,
        errorPinTheme: gf.myDefaultPinTheme,
      ),
    );
  }
}
