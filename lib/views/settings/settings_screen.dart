import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/navigation.dart';
import 'package:get/get.dart';

import '../../widget/appBarWidget.dart';
import 'notification_screen.dart';
import 'settings_account.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
        title: 'Paramètres',
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _createListMenu('Parametres du Compte', Routes.settingAccount,
              Icons.account_circle_outlined),
          _createListMenu('Notifications', Routes.notification,
              Icons.notifications_active_outlined),
        ],
      ),
    );
  }

  Widget _createListMenu(String menuTitle, String route, IconData icon) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => Get.toNamed(route),
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 18, 0, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.width / 1.3,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(menuTitle,
                      style:
                          TextStyle(fontSize: 15, color: AppTheme.darkColor)),
                  Icon(icon, color: AppTheme.darkColor.withOpacity(0.9)),
                ],
              ),
            )

            // Icon(Icons.chevron_right, size: 20, color: AppTheme.secondaryColor),
          ],
        ),
      ),
    );
  }
}
