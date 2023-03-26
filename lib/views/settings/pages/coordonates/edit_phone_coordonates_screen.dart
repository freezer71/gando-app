import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/user/user_controller.dart';
import 'package:gando/navigation.dart';
import 'package:gando/widget/appBarWidget.dart';
import 'package:gando/widget/customTextFormField.dart';
import 'package:gando/widget/submit_with_loading_button.dart';
import 'package:get/get.dart';

class EditPhoneCoordonateScreen extends GetView<UserController> {
  EditPhoneCoordonateScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

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
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          child: Container(
            height: Get.height / 2,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
            child: Form(
              key: _formKey,
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
                    Text("Quel est votre numéro téléphone?",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: AppTheme.darkColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            width: Get.width / 3,
                            height: 60,
                            decoration: BoxDecoration(
                                color: AppTheme.light,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                border: Border.all(
                                    color: AppTheme.darkColor, width: .5)),
                            child: CountryCodePicker(
                              onChanged: controller
                                  .onCountryCodePicked, // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                              initialSelection: 'FR',
                              favorite: ['+33', 'FR'],
                              // optional. Shows only country name and flag
                              showCountryOnly: false,
                              // optional. Shows only country name and flag when popup is closed.
                              showOnlyCountryWhenClosed: false,
                              // optional. aligns the flag and the Text left
                              alignLeft: false,
                              textStyle: TextStyle(color: Colors.black),
                              dialogTextStyle: TextStyle(color: Colors.black),
                              searchStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Padding(
                          padding: const EdgeInsets.only(top: 35.0),
                          child: SizedBox(
                            width: Get.width / 2.3,
                            height: 100,
                            child: CustomTextFormField(
                              keyboardType: TextInputType.phone,
                              autofocus: false,
                              enabled: true,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Numé";
                                }
                              },
                              onChanged: (v) {},
                              onSaved: (v) {},
                              hintText: '07 . 14 . 19 . 20 . 04',
                              formatter: [],
                              controller: controller.phoneTxtController,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: SubmitWithLoadingButton(
                        width: Get.width / 4,
                        text: 'Suivant'.toUpperCase(),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Get.focusScope!.unfocus();
                            controller.handleSigninWithPhone();
                          }
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
      ),
    );
  }
}
