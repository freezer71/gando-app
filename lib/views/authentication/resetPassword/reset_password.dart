import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/helpers/global_function.dart';
import 'package:gando/navigation.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class ResetRecoveryOtpScreen extends StatelessWidget {
  ResetRecoveryOtpScreen({Key? key}) : super(key: key);

  final gf = GlobalFunction();

  TextEditingController pinController = TextEditingController();

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
      onPressed: () => Get.toNamed(Routes.newPwd),
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
          child: Text('Confirmer'.toUpperCase(), style: Theme.of(context).textTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            color: AppTheme.light,
          ),),
        ),
      ),
    );
  }

  Widget buildInput(BuildContext context){
    return Column(
      children: [
        const SizedBox(
          height: 32,
        ),
        Pinput(
          autofocus: false,
          onCompleted: (value) {
            if(value == '1234'){
              Get.toNamed(Routes.newPwd);
            }
          },
          validator: (val){
            return val == "1234" ? null : "invalid_otp".tr;
          },
          errorPinTheme: gf.defaultPinTheme.copyWith(
              decoration: BoxDecoration(
                  color: AppTheme.secondaryColor,
                  border: Border.all(color: const Color.fromRGBO(
                      180, 25, 25, 1.0)),
                  borderRadius: BorderRadius.circular(30)
              )
          ),
          enabled: true,
          textInputAction: TextInputAction.go,
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          length: 4,
          useNativeKeyboard: true,
          keyboardType: TextInputType.number,
          controller: pinController,
          defaultPinTheme: gf.defaultPinTheme,
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
