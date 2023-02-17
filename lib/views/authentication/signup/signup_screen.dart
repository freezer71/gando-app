import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/authController/signup_controller.dart';
import 'package:gando/navigation.dart';
import 'package:gando/widget/submit_with_loading_button.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../helpers/global_function.dart';
import '../../../helpers/global_widget.dart';
import '../../../widget/customTextFormField.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final gf = GlobalFunction();

  final controller = Get.put(SignUpController());

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
            onPressed: (){
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
                    top: AppBar().preferredSize.height + 20,
                  ),
                  children: [
                    Hero(
                        tag: 'logo',
                        child: Image.asset('assets/images/gando-logo.png',
                            height: 100)),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Bienvenue sur Gando \nInscrivez-vous",
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          overflow: TextOverflow.ellipsis,
                          color: HexColor(AppTheme.primaryColorString!),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 18.0, left: 18, right: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            buildSignUpInput(context),
                            const SizedBox(
                              height: 20,
                            ),
                            SubmitWithLoadingButton(
                              isLoading: controller.isLoading.value,
                              text: 'Créer'.toUpperCase(),
                              onPressed: () async {
                                // if check box is not checked
                                if(controller.signUpFormKey.currentState!.validate()){
                                  if (!controller.terms.value) {
                                    Get.snackbar(
                                      'Erreur',
                                      'Vous devez accepter les conditions d\'utilisation',
                                      snackPosition: SnackPosition.TOP,
                                      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                                      backgroundColor: AppTheme.redColor,
                                      colorText: Colors.white,
                                      icon: const Icon(Icons.error_outline, color: Colors.white,),
                                      duration: Duration(seconds: 3),
                                    );
                                    return;
                                  }
                                  // if all is ok
                                  await controller.register();
                                }
                              },
                            ),
                            SizedBox(
                              height: Get.height / 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Vous avez déjà un compte? ",
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
                                    Get.toNamed(Routes.signIn);
                                  },
                                  child: Text(
                                    "Connectez-vous",
                                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis,
                                      color: AppTheme.primaryColor,
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

  Widget buildSignUpInput(BuildContext context) {
    return Form(
      key: controller.signUpFormKey,
      child: Column(
        children: [
          CustomTextFormField(
            key: Get.keys[0],
            controller: controller.lastNameController.value,
            keyboardType: TextInputType.text,
            hintText: 'Votre prénom',
            prefixIcon: const Padding(
              padding: EdgeInsets.only(right: 18.0, left: 18),
              child: Icon(Icons.person),
            ),
            enabled: true,
            validator: (value) {
              if (!gf.isName(value!)) {
                return "Prenom invalide";
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
            }, // default null
            // ... + other textfield params
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            key: Get.keys[1],
            controller: controller.nameController.value,
            keyboardType: TextInputType.text,
            hintText: 'Votre nom',
            enabled: true,
            prefixIcon: const Padding(
              padding: EdgeInsets.only(right: 18.0, left: 18),
              child: Icon(Icons.person),
            ),
            validator: (value) {
              if (!gf.isName(value!)) {
                return "Nom invalide";
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
            }, // default null
            // ... + other textfield params
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            context: context,
            key: Get.keys[2],
            controller: controller.emailController.value,
            obscureText: false,
            enabled: true,
            hintText: "Votre Email",
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Padding(
              padding: EdgeInsets.only(right: 18.0, left: 18),
              child: Icon(Icons.alternate_email),
            ),
            validator: (value) {
              if (!gf.isEmail(value!)) {
                return "Email invalide";
                // return 'amount Is not valid';
              }
              return null;
            },
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
            }, shape: 30.0, // default null
            // ... + other textfield params
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            context: context,
            key: Get.keys[3],
            controller: controller.passwordController.value,
            obscureText: controller.passwordVisible.value,
            enabled: true,
            hintText: 'Mot de passe',
            keyboardType: TextInputType.text,
            prefixIcon: const Padding(
              padding: EdgeInsets.only(right: 18.0, left: 18),
              child: Icon(Icons.lock),
            ),
            validator: (value) {
              if (!gf.isPassword(value!)) {
                if(value.length < 8){
                  return "Mot de passe doit être supérieur à 8 caractères";
                }
                return "Mot de passe invalide";
                // return 'amount Is not valid';
              }
              return null;
            },
            suffixIcon: IconButton(
              icon: Icon(
                controller.passwordVisible.value
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: AppTheme.darkColor.withOpacity(.7),
              ).marginZero.paddingZero,
              onPressed: () {
                controller.passwordVisible.value =
                    !controller.passwordVisible.value;
              },
            ),
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
            }, shape: 30.0, // default null
            // ... + other textfield params
          ),
          const SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              children: [
                Transform.scale(
                  scale: 1.5,
                  child: Checkbox(
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) =>
                        states.contains(MaterialState.disabled)
                            ? AppTheme.darkColor
                            : AppTheme.primaryColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                      ),
                      checkColor: AppTheme.darkColor,
                      value: controller.terms.value,
                      onChanged: (value) {
                        controller.terms.value = !controller.terms.value;
                      }),
                ),
                Container(
                  width: Get.width/ 1.6,
                  child: Text(
                    'En créant un compte, Je reconnais voir pris connaissance des CGU de Gando, de la Politique de Confidentialité et de la chartesur les Cookies et je les accepte.',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 9,
                      overflow: TextOverflow.ellipsis,
                      color: AppTheme.darkColor,
                    ),
                    maxLines: 5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
