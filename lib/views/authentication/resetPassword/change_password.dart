import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/helpers/global_function.dart';
import 'package:gando/navigation.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';


class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);


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
                  top: AppBar().preferredSize.height + 50,
                ),
                children: [
                  Hero(
                      tag: 'logo',
                      child: Image.asset('assets/images/gando-logo.png', height: 140)),
                  const SizedBox(
                    height:  35,
                  ),
                  Center(
                    child: Text(
                      "Changer votre mot de passe",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
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
                          submitButton(context),
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
  }

  Widget submitButton(BuildContext context){
    return TextButton(
      onPressed: () => Get.toNamed(Routes.resetPwd),
      style: ButtonStyle(
        backgroundColor:
        MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) =>
          states.contains(MaterialState.disabled)
              ? AppTheme.primaryColor
              : AppTheme.secondaryColor,
        ),
        overlayColor:
        MaterialStateProperty.all(Colors.transparent),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
      ),
      child: Container(
        height: 40,
        width: Get.width / 1.3,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Center(
          child: Text('Valider', style: Theme.of(context).textTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            color: AppTheme.primaryColor,
          ),),
        ),
      ),
    );
  }

  Widget buildInput(BuildContext context){
    return Column(
      children: [
        TextFormField(
          key: Get.keys[1],
          // controller: controller.topUpAmount.value,
          initialValue: null,
          keyboardType: TextInputType.emailAddress,
          cursorColor: HexColor(AppTheme.primaryColorString!),
          cursorRadius: const Radius.circular(50),
          cursorWidth: 3,
          obscureText: true,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
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
              child: Icon(Icons.lock),
            ),
            enabled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2.0,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(16.0),
              gapPadding: 8.0,
            ),
            labelText: "Nouveau mot de passe",
            labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
              color: HexColor(AppTheme.primaryColorString!),
            ),
            hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
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
                borderRadius: BorderRadius.circular(16.0),
                gapPadding: 8.0),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red.withOpacity(0.4),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(16.0),
                gapPadding: 8.0),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(16.0),
                gapPadding: 8.0),
          ),
          validator: (value) {
            if (!value!.isEmail) {
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
            LengthLimitingTextInputFormatter(20),
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
        const SizedBox(height: 15,),
        TextFormField(
          key: Get.keys[2],
          // controller: controller.topUpAmount.value,
          initialValue: null,
          keyboardType: TextInputType.emailAddress,
          cursorColor: HexColor(AppTheme.primaryColorString!),
          cursorRadius: const Radius.circular(50),
          cursorWidth: 3,
          obscureText: true,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
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
              child: Icon(Icons.lock),
            ),
            enabled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2.0,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(16.0),
              gapPadding: 8.0,
            ),
            labelText: "Confirmer le mot de passe",
            labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
              color: HexColor(AppTheme.primaryColorString!),
            ),
            hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
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
                borderRadius: BorderRadius.circular(16.0),
                gapPadding: 8.0),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red.withOpacity(0.4),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(16.0),
                gapPadding: 8.0),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(16.0),
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
      ],
    );
  }
}
