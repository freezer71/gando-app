import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/user/user_controller.dart';
import 'package:gando/helpers/global_function.dart';
import 'package:gando/navigation.dart';
import 'package:gando/widget/appBarWidget.dart';
import 'package:gando/widget/customTextFormField.dart';
import 'package:gando/widget/submit_with_loading_button.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class VerifyPhoneCoordonateScreen extends GetView<UserController> {
  VerifyPhoneCoordonateScreen({Key? key}) : super(key: key);
  final globalFunction = GlobalFunction();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
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
        title: 'Mes coordonnées',
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 30.0),
          child: Container(
            height: Get.height / 3,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Complétez mes coordonnées",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: AppTheme.darkColor,
                            fontSize: 16,
                          )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Entrez le code de vérification envoyé par SMS.",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: AppTheme.darkColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  buildInput(context),
                  Align(
                    alignment: Alignment.center,
                    child: Text("Vous n'avez pas reçu ? Renvoyer",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: AppTheme.darkColor,
                              fontSize: 12,
                            )),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: SubmitWithLoadingButton(
                      width: Get.width / 4,
                      text: 'Suivant'.toUpperCase(),
                      onPressed: () {
                        controller.onVerifyCode();
                      },
                      isLoading: controller.isLoading.value,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInput(BuildContext context) {
    return Pinput(
      autofocus: false,
      key: Get.keys[0],
      validator: (val) {
        if (!globalFunction.isOtp(val!)) {
          return "Code invalide";
        }
        return null;
      },
      errorPinTheme: globalFunction.defaultPinTheme.copyWith(
          textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 42,
                color: AppTheme.darkColor,
              ),
          decoration: BoxDecoration(
              color: AppTheme.redColor,
              border: Border.all(
                color: AppTheme.redColor,
              ),
              borderRadius: BorderRadius.circular(30))),
      enabled: true,
      textInputAction: TextInputAction.go,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      length: 6,
      useNativeKeyboard: true,
      keyboardType: TextInputType.number,
      controller: controller.pinController.value,
      defaultPinTheme: globalFunction.defaultPinTheme,
    );
  }
}
