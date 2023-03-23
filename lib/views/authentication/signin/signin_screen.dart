import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/generated/assets.dart';
import 'package:gando/helpers/global_function.dart';
import 'package:gando/navigation.dart';
import 'package:get/get.dart';

import '../../../controllers/authController/signin_controller.dart';
import '../../../widget/customTextFormField.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final controller = Get.put(SignInController());

  final gf = GlobalFunction();

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
            icon: Icon(
              Icons.arrow_back,
              color: AppTheme.darkColor,
            ),
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
                        child: Image.asset(Assets.imagesGandoLogo,
                            height: 100)),
                    const SizedBox(
                      height: 35,
                    ),
                    Text(
                      "Bon retour parmis nous",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                        overflow: TextOverflow.ellipsis,
                        color: AppTheme.darkColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Center(
                      child: Text(
                        "Connectez-vous ",
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis,
                          color: AppTheme.darkColor,

                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            buildSignInInput(context),
                            const SizedBox(
                              height: 40,
                            ),
                            submitButton(context),
                            SizedBox(
                              height: Get.height / 14,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Vous n'avez pas de compte ? ",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                    color: HexColor(
                                        AppTheme.primaryColorString!),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.signUp);
                                  },
                                  child: Text(
                                    "Inscrivez-vous",
                                    style: TextStyle(
                                      color: AppTheme.primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
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

  Widget submitButton(BuildContext context) {
    return TextButton(
      onPressed: () async{
        if(controller.signInFormKey.currentState!.validate()){
          await controller.signIn();
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) =>
          controller.isLoading.value
              ? AppTheme.primaryColor.withOpacity(0.5)
              : AppTheme.primaryColor,
        ),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        )),
      ),
      child: Container(
        height: 40,
        width: Get.width / 1.3,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Center(
            child: !controller.isLoading.value ? Text(
              'Connexion'.toUpperCase(),
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: AppTheme.backgroundColor,
              ),
            ) : const CircularProgressIndicator.adaptive()
        ),
      ),
    );
  }

  Widget buildSignInInput(BuildContext context) {
    return Form(
      key: controller.signInFormKey,
      child: Column(
        children: [
          CustomTextFormField(
            key: Get.keys[4],
            controller: controller.emailController.value,
            keyboardType: TextInputType.emailAddress,
            enabled: true,
            validator: (value) {
              if (!value!.isEmail) {
                return "Email invalide";
              }
              return null;
            },
            autofocus: false,
            formatter: [
              LengthLimitingTextInputFormatter(60),
              FilteringTextInputFormatter.singleLineFormatter
            ],
            // default
            onSaved: (p) {
              print('saved $p');
            },
            // default null
            onChanged: (p) {
              // if (p.validateAmount) {
              //   topUpController.buttonDisabled.value = false;
              // } else {
              //   topUpController.buttonDisabled.value = true;
              // }
            },
            context: context,
            obscureText: false,
            prefixIcon: const Padding(
              padding: EdgeInsets.only(right: 18.0, left: 18),
              child: Icon(Icons.alternate_email_outlined),
            ),
            shape: 30,
            hintText: 'Votre email', // default null
            // ... + other textfield params
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            key: Get.keys[5],
            controller: controller.passwordController.value,
            keyboardType: TextInputType.emailAddress,
            enabled: true,
            validator: (value) {
              if (!gf.isPassword(value!)) {
                return "Mot de passe invalide";
              }
              return null;
            },
            autofocus: false,
            formatter: [
              LengthLimitingTextInputFormatter(30),
              FilteringTextInputFormatter.singleLineFormatter
            ],
            onSaved: (p) {
              print('saved $p');
            },
            onChanged: (p) {

            },
            context: context,
            obscureText: true,
            prefixIcon: const Padding(
              padding: EdgeInsets.only(right: 18.0, left: 18),
              child: Icon(Icons.lock),
            ),
            shape: 30,
            hintText: 'Mot de passe', // default null
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              Get.toNamed(Routes.forgotPwd, arguments:
                controller.emailController.value.text.isEmpty ? null : {
                          'email': controller.emailController.value.text
              }); // if email is not empty);
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Mot de passe oublié?',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
