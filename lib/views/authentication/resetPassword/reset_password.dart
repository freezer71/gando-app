import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/helpers/global_function.dart';
import 'package:gando/navigation.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../controllers/authController/auth_controller.dart';
import '../../../widget/submit_with_loading_button.dart';

class ResetRecoveryOtpScreen extends StatelessWidget {
  ResetRecoveryOtpScreen({Key? key}) : super(key: key);

  final gf = GlobalFunction();
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          backwardsCompatibility: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppTheme.darkColor,),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: InkWell(
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
                        child: Image.asset(
                            'assets/images/gando-logo.png', height: 140)),
                    const SizedBox(
                      height: 35,
                    ),
                    Center(
                      child: Text(
                        "Saisissez le code OTP que vous avez recu par email",
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(
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
                          key: controller.forgotPasswordFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40,),
                              buildInput(context),
                              const SizedBox(height: 60,),
                              SubmitWithLoadingButton(
                                onPressed: () => checkPreviousPage(),
                                text: 'Confirmer'.toUpperCase(),
                                isLoading: false,
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
      );
    });
  }

  Widget buildInput(BuildContext context) {
    return Pinput(
        autofocus: false,
        key: Get.keys[0],
        /*onCompleted: (value) {
          if (controller.forgotPasswordFormKey
              .currentState!
              .validate()) {
            controller.forgotPasswordFormKey.currentState!
                .save();
            if (!gf.isOtp(
                controller.pinController.value.text)) {
              Get.snackbar("Code invalide", "Le code doit contenir 6 chiffres",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                  margin: const EdgeInsets.all(10),
                  borderRadius: 10,
                  icon: const Icon(Icons.error, color: Colors.white,)
              );
            }else {
              Get.toNamed(Routes.newPwd,
                  arguments: {'otp': value, 'email': Get.arguments['email']});
              printInfo(info: "${Get.arguments}");
            }
          }
        },*/
        validator: (val) {
          if (!gf.isOtp(val!)) {
            return "Code invalide";
          }
          return null;
        },
        errorPinTheme: gf.defaultPinTheme.copyWith(
            textStyle: Theme
                .of(context)
                .textTheme
                .bodyText2!
                .copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 42,
              color: AppTheme.darkColor,
            ),
            decoration: BoxDecoration(
                color: AppTheme.redColor,
                border: Border.all(color: AppTheme.redColor,),
                borderRadius: BorderRadius.circular(30)
            )
        ),
        enabled: true,
        textInputAction: TextInputAction.go,
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        length: 6,
        useNativeKeyboard: true,
        keyboardType: TextInputType.number,
        controller: controller.pinController.value,
        defaultPinTheme: gf.defaultPinTheme,
    );
  }

  // check previous page form arguments
  void checkPreviousPage() {
    if (Get.arguments != null) {
      if (Get.arguments['previousPage'] != null) {
        if(Get.arguments['previousPage'] == 'forgotPassword'){
          Get.toNamed(Routes.newPwd, arguments: {
            'otp': controller.pinController.value.text,
            'email': Get.arguments['email']
          });
        }else if(Get.arguments['previousPage'] == 'register'){
          // go home page
          if (controller.forgotPasswordFormKey
              .currentState!
              .validate()) {
            if (gf.isOtp(
                controller.pinController.value.text)) {
              controller.verifyPin();
            }
            return;
          }
        }
      }
    }
  }
}
