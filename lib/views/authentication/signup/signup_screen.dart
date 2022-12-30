import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/authController/signup_controller.dart';
import 'package:gando/navigation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
      onPressed: () => Get.toNamed(Routes.home),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) =>
          states.contains(MaterialState.disabled)
              ? AppTheme.primaryColor
              : AppTheme.darkColor,
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
          child: Text(
            'Créer',
            style: Theme
                .of(context)
                .textTheme
                .bodyText2!
                .copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: AppTheme.backgroundColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignUpInput(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          key: Get.keys[2],
          // controller: controller.topUpAmount.value,
          initialValue: null,
          keyboardType: TextInputType.emailAddress,
          cursorColor: HexColor(AppTheme.primaryColorString!),
          cursorRadius: const Radius.circular(50),
          cursorWidth: 3,
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
          enabled: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppTheme.light,
            prefixIconColor: AppTheme.backgroundColor,
            prefixIcon: const Padding(
              padding: EdgeInsets.only(right: 18.0, left: 18),
              child: Icon(Icons.person),
            ),
            enabled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2.0,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(30.0),
              gapPadding: 8.0,
            ),
            hintText: "Votre prénom",
            labelStyle: Theme
                .of(context)
                .textTheme
                .bodyText2!
                .copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
              color: HexColor(AppTheme.primaryColorString!),
            ),
            hintStyle: Theme
                .of(context)
                .textTheme
                .bodyText2!
                .copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
              color: HexColor(AppTheme.primaryColorString!),
            ),
            errorMaxLines: 3,
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
                gapPadding: 8.0),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red.withOpacity(0.4),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
                gapPadding: 8.0),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
                gapPadding: 8.0),
          ),
          validator: (value) {
            if (!value!.isAlphabetOnly) {
              return "Prenom invalide";
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofocus: false,
          inputFormatters: [
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
        TextFormField(
          key: Get.keys[2],
          // controller: controller.topUpAmount.value,
          initialValue: null,
          keyboardType: TextInputType.emailAddress,
          cursorColor: HexColor(AppTheme.primaryColorString!),
          cursorRadius: const Radius.circular(50),
          cursorWidth: 3,
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
          enabled: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppTheme.light,
            prefixIconColor: AppTheme.backgroundColor,
            prefixIcon: const Padding(
              padding: EdgeInsets.only(right: 18.0, left: 18),
              child: Icon(Icons.person),
            ),
            enabled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2.0,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(30.0),
              gapPadding: 8.0,
            ),
            hintText: "Votre nom",
            labelStyle: Theme
                .of(context)
                .textTheme
                .bodyText2!
                .copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
              color: HexColor(AppTheme.primaryColorString!),
            ),
            hintStyle: Theme
                .of(context)
                .textTheme
                .bodyText2!
                .copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
              color: HexColor(AppTheme.primaryColorString!),
            ),
            errorMaxLines: 3,
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
                gapPadding: 8.0),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red.withOpacity(0.4),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
                gapPadding: 8.0),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
                gapPadding: 8.0),
          ),
          validator: (value) {
            if (!value!.isAlphabetOnly) {
              return "Nom invalide";
              // return 'amount Is not valid';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofocus: false,
          inputFormatters: [
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
        TextFormField(
          key: Get.keys[2],
          // controller: controller.topUpAmount.value,
          initialValue: null,
          keyboardType: TextInputType.emailAddress,
          cursorColor: HexColor(AppTheme.primaryColorString!),
          cursorRadius: const Radius.circular(50),
          cursorWidth: 3,
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
          enabled: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppTheme.light,
            prefixIconColor: AppTheme.backgroundColor,
            prefixIcon: const Padding(
              padding: EdgeInsets.only(right: 18.0, left: 18),
              child: Icon(Icons.alternate_email),
            ),
            enabled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2.0,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(30.0),
              gapPadding: 8.0,
            ),
            hintText: "Votre email",
            labelStyle: Theme
                .of(context)
                .textTheme
                .bodyText2!
                .copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
              color: HexColor(AppTheme.primaryColorString!),
            ),
            hintStyle: Theme
                .of(context)
                .textTheme
                .bodyText2!
                .copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
              color: HexColor(AppTheme.primaryColorString!),
            ),
            errorMaxLines: 3,
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
                gapPadding: 8.0),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red.withOpacity(0.4),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
                gapPadding: 8.0),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
                gapPadding: 8.0),
          ),
          validator: (value) {
            if (!value!.isEmail) {
              return "Email invalid";
              // return 'amount Is not valid';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofocus: false,
          inputFormatters: [
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
        TextFormField(
          key: Get.keys[2],
          // controller: controller.topUpAmount.value,
          initialValue: null,
          obscureText: true,
          keyboardType: TextInputType.emailAddress,
          cursorColor: HexColor(AppTheme.primaryColorString!),
          cursorRadius: const Radius.circular(50),
          cursorWidth: 3,
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
          enabled: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppTheme.light,
            suffixIcon: const Padding(
              padding: EdgeInsets.only(right: 18.0, left: 18),
              child: InkWell(
                focusColor: Colors.transparent,
                child: Icon(Icons.remove_red_eye_sharp),
              ),
            ),
            prefixIconColor: AppTheme.backgroundColor,
            prefixIcon: const Padding(
              padding: EdgeInsets.only(right: 18.0, left: 18),
              child: Icon(Icons.lock_outlined),
            ),
            enabled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2.0,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(30.0),
              gapPadding: 8.0,
            ),
            hintText: "Mot de passe",
            labelStyle: Theme
                .of(context)
                .textTheme
                .bodyText2!
                .copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
              color: HexColor(AppTheme.primaryColorString!),
            ),
            hintStyle: Theme
                .of(context)
                .textTheme
                .bodyText2!
                .copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
              color: HexColor(AppTheme.primaryColorString!),
            ),
            errorMaxLines: 3,
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
                gapPadding: 8.0),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red.withOpacity(0.4),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
                gapPadding: 8.0),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
                gapPadding: 8.0),
          ),
          validator: (value) {
            if (!value!.isAlphabetOnly) {
              return "Mot de passe invalide";
              // return 'amount Is not valid';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofocus: false,
          inputFormatters: [
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
          height: 15,
        ),
        Align(
          alignment: Alignment.center,
          child: Row(
            children: [
              Checkbox(
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) =>
                    states.contains(MaterialState.disabled)
                        ? AppTheme.secondaryColor
                        : AppTheme.primaryColor,
                  ),
                  checkColor: AppTheme.secondaryColor,
                  value: controller.terms.value,
                  onChanged: (value) {
                    controller.terms.value = !controller.terms.value;
                  }),
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
                    color: AppTheme.secondaryColor,
                  ),
                  maxLines: 5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
