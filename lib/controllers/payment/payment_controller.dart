import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/views/products/booking/success_booking_screen.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  Rx<CardFormEditController> cardFormController = CardFormEditController().obs;
  Rx<bool> isLoading = false.obs;
  bool isCardComplete = false;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> nomTitulaireController =
      TextEditingController().obs;

  void updateCard({CardFieldInputDetails? cardFieldInputDetails}) {
    isCardComplete = cardFieldInputDetails!.complete;
  }

  Future<void> handleSavePress() async {
    if (isCardComplete == false) {
      Get.snackbar('Erreur', "Veuillez remplir tous les champs",
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.redColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 2));
      return;
    }
    isLoading(true);
    try {
      // Gather customer billing information (ex. email)
      final billingDetails = BillingDetails(
        email: emailController.value.text,
        name: nomTitulaireController.value.text,
      );

      //  Confirm setup intent

      final setupIntentResult = await Stripe.instance.confirmPayment(
        paymentIntentClientSecret:
            "pi_3MuLIwCvgEqGijXi1yrheHsZ_secret_BtypSbG3YVogolrDqVYXQYi84",
        data: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: billingDetails,
          ),
        ),
      );
      Get.snackbar('Mise à jour', "Payé avec succés",
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.secondaryColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 3));
      isLoading(false);
      Get.to(() => const SuccessBookingScreen());
    } catch (error, s) {
      Get.snackbar('Paiement failed', "Error code $error",
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.redColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 3));
      isLoading(false);
    }
  }
}
