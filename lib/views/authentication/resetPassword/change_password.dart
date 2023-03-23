import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/helpers/global_function.dart';
import 'package:gando/navigation.dart';
import 'package:gando/widget/submit_with_loading_button.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../controllers/authController/auth_controller.dart';
import '../../../widget/customTextFormField.dart';


class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

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
                  "Changer votre mot de passe",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    overflow: TextOverflow.ellipsis,
                    color: HexColor(AppTheme.primaryColorString!),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20,),
                      buildInput(context),
                      const SizedBox(height: 40,),
                      SubmitWithLoadingButton(
                        text: 'Valider'.toUpperCase(),
                        onPressed: () {
                          controller.changePassword();
                        },
                        isLoading: controller.isLoading.value,
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget submitButton(BuildContext context) {
    return TextButton(
      onPressed: () => Get.toNamed(Routes.resetPwd),
      style: ButtonStyle(
        backgroundColor:
        MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) => AppTheme.primaryColor
        ),
        overlayColor:
        MaterialStateProperty.all(Colors.transparent),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            )),
      ),
      child: Container(
        width: Get.width / 1.3,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Center(
          child: Text('Valider'.toUpperCase(), style: Theme
              .of(context)
              .textTheme
              .bodyText2!
              .copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 18,
            color: AppTheme.light,
          ),),
        ),
      ),
    );
  }

  Widget buildInput(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
            key: Get.keys[7],
            keyboardType: TextInputType.visiblePassword,
            controller: controller.recoverPassword.value,
            validator: (value) {
              if (gf.isPassword(value!)) {
                return "Mot de passe invalid";
              }
              return null;
            },
            prefixIcon: Icon(Icons.lock),
            formatter: [
              LengthLimitingTextInputFormatter(60),
              FilteringTextInputFormatter.singleLineFormatter
            ],
            onChanged: (p) {
              print('saved $p');
            },
            onSaved: (p) {
              print('saved $p');
            },
            hintText: 'Nouveau mot de passe'),
        const SizedBox(height: 15,),
        CustomTextFormField(
            key: Get.keys[8],
            obscureText: true,
            controller: controller.confirmRecoverPassword.value,
            keyboardType: TextInputType.visiblePassword,
            validator: (value) {
              if (gf.isPassword(value!)) {
                // check is match password
                if (value != controller.recoverPassword.value.text) {
                  return "Les mots de passe ne correspondent pas";
                }
                return "Confirmer mot de passe invalid";
                // return 'amount Is not valid';
              }
              return null;
            },
            prefixIcon: const Icon(Icons.lock),
            formatter: [
              LengthLimitingTextInputFormatter(60),
              FilteringTextInputFormatter.singleLineFormatter
            ],
            onChanged: (p) {
              print('saved $p');
            },
            onSaved: (p) {
              print('saved $p');
            },
            hintText: 'Confirmer mot de passe'),
      ],
    );
  }
}
