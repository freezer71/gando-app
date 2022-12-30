import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:get/get.dart';

import 'notification_screen.dart';
import 'settings_account.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios_outlined, color: AppTheme.darkColor,),),
        title: Text(
          'Paramètres',
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              overflow: TextOverflow.ellipsis,
              color: AppTheme.darkColor
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Divider(
            color: AppTheme.darkColor,
          ),
          _createListMenu('Parametres du Compte', SettingsAccountScreen(),
              Icons.account_circle_outlined),
          _createListMenu('Notifications', NotificationScreen(),
              Icons.notifications_active_outlined),
        ], 
      ),
    );
  }

  Widget _createListMenu(String menuTitle, StatelessWidget page, IconData icon) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => Get.to(() => page),
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
                      style: TextStyle(
                          fontSize: 15, color: AppTheme.darkColor)),
                  Icon(icon,
                      color: AppTheme.darkColor.withOpacity(0.9)),
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
