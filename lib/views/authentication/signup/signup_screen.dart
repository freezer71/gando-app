import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/authController/signup_controller.dart';
import 'package:gando/navigation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../helpers/global_widget.dart';
import '../../../widget/customTextFormField.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SignUpController());

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
                            height: 90)),
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
                            submitButton(context),
                            SizedBox(
                              height: Get.height / 22,
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
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                      color: HexColor(AppTheme.primaryColorString!),
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
      onPressed: () {
        if(controller.formKey.currentState!.validate()){
          controller.register();
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) => controller.isLoading.value ? AppTheme.primaryColor.withOpacity(0.5) : AppTheme.primaryColor,
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
            'Créer'.toUpperCase(),
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

  Widget buildSignUpInput(BuildContext context) {
    return Form(
      key: controller.formKey,
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
              if (!value!.isAlphabetOnly) {
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
              if (!value!.isAlphabetOnly) {
                return "Nom invalide";
                // return 'amount Is not valid';
              }
              return null;
            },
            autofocus: false,
            formatter: [
              // FilteringTextInputFormatter.deny(
              //   RegExp(r"^((5000)|([0-4]?[0-9]{1,3}))$"),
              // ),
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
              if (!value!.isEmail) {
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
            obscureText: true,
            enabled: true,
            hintText: 'Mot de passe',
            keyboardType: TextInputType.text,
            prefixIcon: const Padding(
              padding: EdgeInsets.only(right: 18.0, left: 18),
              child: Icon(Icons.lock),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                if(value.length < 8){
                  return "Mot de passe doit être supérieur à 8 caractères";
                }
                return "Mot de passe invalide";
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
