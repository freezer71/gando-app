import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/wallet/wallet_controller.dart';
import 'package:gando/widget/appBarWidget.dart';
import 'package:gando/widget/customTextFormField.dart';
import 'package:get/get.dart';

class WalletScreen extends GetView<WalletController> {
  const WalletScreen({Key? key}) : super(key: key);

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
        title: 'Porte-monnaie',
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          children: [
            const SizedBox(height: 20.0),
            Center(
              child: Text("Voici votre solde ",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: AppTheme.darkColor)),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wallet_giftcard_rounded,
                  size: 30,
                  color: AppTheme.darkColor,
                ),
                const SizedBox(width: 25.0),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.darkColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  height: Get.height / 12,
                  width: Get.width / 2.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '184,55€',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Text(
                "Ce solde vous permet de louer d'autres véhicules ou le déposer directement "
                "sur vore compte bancaire ",
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.darkColor,
                )),
            const SizedBox(height: 35.0),
            _createListMenu("Virement bancaire", context),
            Text("IBAN complet",
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.darkColor,
                )),
            const SizedBox(height: 15.0),
            CustomTextFormField(
              controller: controller.ibanControllerField.value,
              keyboardType: TextInputType.text,
              enabled: false,
              formatter: [],
              validator: (value) {},
              hintText: "XXXXXXXXXXXx",
              onChanged: (String) {},
              onSaved: (String) {},
            ),
            const SizedBox(height: 20.0),
            Text(
              "Code BIC",
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.darkColor,
              ),
            ),
            const SizedBox(height: 15.0),
            CustomTextFormField(
              controller: controller.ibanControllerField.value,
              keyboardType: TextInputType.text,
              enabled: false,
              formatter: [],
              validator: (value) {},
              hintText: "XXXXXXXXXXXx",
              onChanged: (String) {},
              onSaved: (String) {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _createListMenu(String menuTitle, context) {
    return Container(
      width: Get.width / 2,
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: Text(menuTitle,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      overflow: TextOverflow.visible,
                      color: AppTheme.darkColor.withOpacity(0.7),
                    )),
          ),
          Expanded(
            child: Container(
                width: Get.width / 4,
                child: Divider(
                  indent: 2,
                  thickness: 2,
                  height: 20,
                  color: AppTheme.darkColor.withOpacity(0.2),
                )),
          )
        ],
      ),
    );
  }
}
