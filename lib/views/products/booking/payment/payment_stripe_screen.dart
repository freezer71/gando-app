import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/payment/payment_controller.dart';
import 'package:gando/widget/appBarWidget.dart';
import 'package:gando/widget/submit_with_loading_button.dart';
import 'package:get/get.dart';

class PaymentStripeScreen extends GetView<PaymentController> {
  const PaymentStripeScreen({Key? key}) : super(key: key);

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
        title: 'Paiement Stripe',
      ),
      body: Obx(
        () => Column(
          children: [
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: CardFormField(
                style: CardFormStyle(
                    borderWidth: 2, borderColor: AppTheme.primaryColor),
                controller: controller.cardFormController.value,
                onCardChanged: (card) {
                  controller.updateCard(cardFieldInputDetails: card);
                },
              ),
            ),
            const SizedBox(height: 20.0),
            SubmitWithLoadingButton(
              text: 'Payer'.toUpperCase(),
              onPressed: () async {
                Get.focusScope!.unfocus();
                await controller.handleSavePress();
              },
              isLoading: controller.isLoading.value,
            ),
          ],
        ),
      ),
    );
  }
}
