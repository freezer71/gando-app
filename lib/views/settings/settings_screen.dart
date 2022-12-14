import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/views/home/home.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Mon Gando',
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                overflow: TextOverflow.ellipsis,
              ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          buildRowMenu(),
          Divider(
            height: Get.height / 12,
            color: AppTheme.darkColor,
          ),
          _createListMenu('Parametres du Compte', HomeScreen(),
              Icons.account_circle_outlined),
          _createListMenu('Notifications', HomeScreen(),
              Icons.notifications_active_outlined),
          _createListMenu('FAQ', HomeScreen(), Icons.help),
        ],
      ),
    );
  }

  Widget buildRowMenu() {
    return Container(
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
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
                  Icon(Icons.person_pin, size: 40,),
                  SizedBox(height: 10,),
                  Text(
                    'Mon profil',
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
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
                  Icon(Icons.settings_outlined, size: 40,),
                  SizedBox(height: 10,),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(menuTitle,
                            style: TextStyle(
                                fontSize: 15, color: AppTheme.backgroundColor)),
                        Icon(icon,
                            color: AppTheme.backgroundColor.withOpacity(0.9)),
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
