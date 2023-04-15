import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/payment/payment_controller.dart';
import 'package:gando/helpers/global_function.dart';
import 'package:gando/widget/appBarWidget.dart';
import 'package:gando/widget/customTextFormField.dart';
import 'package:gando/widget/submit_with_loading_button.dart';
import 'package:get/get.dart';

class PaymentStripeScreen extends GetView<PaymentController> {
  PaymentStripeScreen({Key? key}) : super(key: key);
  final gf = GlobalFunction();
  final formKey = GlobalKey<FormState>();
  final phoneTxtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: AppBar(
          backgroundColor: AppTheme.darkColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              Get.back();
            },
          ),
          flexibleSpace: Container(
            alignment: Alignment.center,
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(children: [
                TextSpan(
                    text: '\nProduct Name \n',
                    style: TextStyle(fontSize: 14.0)),
                TextSpan(
                  text: '0,00 € ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25.0, height: 2.0),
                ),
              ]),
            ),
          ),
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "E-mail",
                        style: TextStyle(color: AppTheme.darkColor),
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        textAlignVertical: TextAlignVertical.center,
                        controller: controller.emailController.value,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0.5,
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              gapPadding: 1.0),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              gapPadding: 1.0),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              gapPadding: 1.0),
                        ),
                        cursorColor: AppTheme.primaryColor,
                        validator: (value) {
                          if (!gf.isEmail(value!)) {
                            return "Email invalide";
                          }
                          return null;
                        },
                        style: TextStyle(color: AppTheme.darkColor),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Nom du titulaire de la carte",
                        style: TextStyle(color: AppTheme.darkColor),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0.5,
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              gapPadding: 1.0),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              gapPadding: 1.0),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              gapPadding: 1.0),
                        ),
                        cursorColor: AppTheme.primaryColor,
                        style: TextStyle(color: AppTheme.darkColor),
                        textAlignVertical: TextAlignVertical.center,
                        controller: controller.nomTitulaireController.value,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Nom du titulaire de la carte obligatoire";
                          }
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Informations de la carte",
                        style: TextStyle(color: AppTheme.darkColor),
                      ),
                      CardFormField(
                        controller: controller.cardFormController.value,
                        onCardChanged: (card) {
                          controller.updateCard(cardFieldInputDetails: card);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              SubmitWithLoadingButton(
                text: 'Payer'.toUpperCase(),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    Get.focusScope!.unfocus();
                    await controller.handleSavePress();
                  }
                },
                isLoading: controller.isLoading.value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
