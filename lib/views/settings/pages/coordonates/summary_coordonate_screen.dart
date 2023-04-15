import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/user/user_controller.dart';
import 'package:gando/widget/appBarWidget.dart';
import 'package:gando/widget/detail_screen.dart';
import 'package:get/get.dart';
import 'package:gando/views/settings/pages/coordonates/home_coordonates_screen.dart';
import 'package:intl/intl.dart';

class SummaryCoordonateView extends GetView<UserController> {
  const SummaryCoordonateView({Key? key}) : super(key: key);

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
        () => SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DetailScreen(
                    header: "Civilité", value: controller.user.value.civility),
                DetailScreen(
                    header: "Numéro de téléphone",
                    value: controller.user.value.phone),
                DetailScreen(
                    header: "Date de naissance",
                    value: controller.user.value.dayOfBirth == null
                        ? ''
                        : DateFormat('d MMM yyyy')
                            .format(controller.user.value.dayOfBirth!)),
                DetailScreen(
                    header: "Lieu de naissance",
                    value: controller.user.value.birthplace),
                DetailScreen(
                    header: "Adresse",
                    value: controller.user.value.address?.address),
                DetailScreen(
                    header: "Complément d'adresse",
                    value: controller.user.value.address?.complement),
                DetailScreen(
                    header: "Pays",
                    value: controller.user.value.address?.country),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DetailScreen(
                        header: "Code Postal",
                        value: controller.user.value.address?.zipCode),
                    SizedBox(
                      width: 50.0,
                    ),
                    DetailScreen(
                        header: "Ville",
                        value: controller.user.value.address?.city),
                  ],
                ),
                SizedBox(
                  height: 25.0,
                ),
                TextButton(
                  onPressed: () {
                    //Get.toNamed(Routes.detailCordonate);
                    Get.to(() => HomeCordonatesView());
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith<Color>((states) {
                      return AppTheme.primaryColor;
                    }),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
                  ),
                  child: Container(
                    height: 40,
                    width: Get.width / 1.3,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: Center(
                      child: Text(
                        'Mettre à jour mon profil'.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: AppTheme.light,
                            ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
