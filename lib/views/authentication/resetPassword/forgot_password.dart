import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/authController/auth_controller.dart';
import 'package:gando/navigation.dart';
import 'package:gando/widget/customTextFormField.dart';
import 'package:get/get.dart';

import '../../../widget/submit_with_loading_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

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
            icon: Icon(
              Icons.arrow_back,
              color: AppTheme.darkColor,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: ListView(
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
                "Récuperer votre mot de passe",
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
                child: Form(
                  key: controller.forgotPasswordFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      buildInput(context),
                      const SizedBox(
                        height: 20,
                      ),
                      SubmitWithLoadingButton(
                        onPressed: () async {
                          if (controller.forgotPasswordFormKey
                              .currentState!.validate()) {
                            // controller.forgotPasswordFormKey
                            //     .currentState!.save();
                            await controller.forgotPassword();
                          }
                        },
                        text: 'Récuperer',
                        isLoading: controller.isLoading.value,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget buildInput(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
            key: Get.keys[9],
            keyboardType: TextInputType.emailAddress,
            controller: controller.forgotEmailController.value,
            validator: (value) {
              if (!value!.isEmail) {
                return "Email invalid";
                // return 'amount Is not valid';
              }
              return null;
            },
            prefixIcon: Icon(Icons.alternate_email),
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
            hintText: 'Votre email'),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
