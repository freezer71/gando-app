import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/navigation.dart';
import 'package:gando/widget/appBarWidget.dart';
import 'package:get/get.dart';

class HomeCordonatesView extends StatelessWidget {
  const HomeCordonatesView({Key? key}) : super(key: key);

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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 40.0),
        child: Container(
          height: Get.height / 4,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: AppTheme.light,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Complétez mes coordonnées",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppTheme.darkColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  color: AppTheme.darkColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                        "On y est presque ! Avant nous avons besoin de quelques "
                        "informations. Seulement pour cette fois.",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: AppTheme.darkColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () => Get.toNamed(Routes.editPhoneCoordonate),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppTheme.primaryColor,
                      ),
                      height: 40,
                      width: Get.width / 5.0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: Center(
                        child: Text(
                          'OK',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                    color: AppTheme.backgroundColor,
                                  ),
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
