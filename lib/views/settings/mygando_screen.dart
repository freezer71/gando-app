import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/user/user_controller.dart';
import 'package:gando/models/ProfileSeller.dart';
import 'package:gando/navigation.dart';
import 'package:gando/services/auth/auth_services.dart';
import 'package:gando/views/home/home.dart';
import 'package:gando/views/settings/pages/profile_screen.dart';
import 'package:get/get.dart';

import '../../config/constants.dart';
import '../../widget/appBarWidget.dart';
import 'settings_screen.dart';

class MyGandoScreen extends StatelessWidget {
  const MyGandoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: CustomAppBar(
        title: 'Mon Gando',
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          buildRowMenu(),
          Divider(
            height: Get.height / 12,
            color: AppTheme.darkColor,
          ),
          _createListMenu('Centre d\'aide', HomeScreen(), Icons.help_outline),
          _createListMenu('Nous contactez', HomeScreen(), Icons.phone),
          _createListMenu(
              'Conditions d\'utilisation', HomeScreen(), Icons.inventory),
        ],
      ),
    );
  }

  Widget buildRowMenu() {
    final seller = ProfileSeller(
      'Marco DEGARDIO',
      'assets/images/av.png',
      'lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum  ',
      8,
      2,
      [],
      true,
      '5/5',
      DateTime.now(),
    );

    return Container(
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.profile);
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.darkColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              height: Get.height / 5,
              width: Get.width / 2.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.person_pin,
                    size: 80,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Mon profil',
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Get.to(() => const SettingsScreen()),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.darkColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              height: Get.height / 5,
              width: Get.width / 2.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.settings_outlined,
                    size: 80,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Parametres',
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createListMenu(String menuTitle, page, IconData icon) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.to(() => page);
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 18, 0, 8),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) =>
                          states.contains(MaterialState.disabled)
                              ? AppTheme.primaryColor
                              : AppTheme.darkColor,
                    ),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
                  ),
                  onPressed: () {},
                  child: SizedBox(
                    width: Get.width / 1.5,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(icon,
                            color: AppTheme.backgroundColor.withOpacity(0.9)),
                        Text(menuTitle,
                            style: TextStyle(
                                fontSize: 15, color: AppTheme.backgroundColor)),
                      ],
                    ),
                  ))

              // Icon(Icons.chevron_right, size: 20, color: AppTheme.secondaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
