import 'package:flutter/material.dart';
import 'package:gando/config/config.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/user/user_controller.dart';
import 'package:gando/models/ProfileSeller.dart';
import 'package:gando/models/User.dart';
import 'package:gando/navigation.dart';
import 'package:gando/views/settings/pages/coordonates/home_coordonates_screen.dart';
import 'package:gando/views/settings/pages/social_network_screen.dart';
import 'package:gando/widget/loading_dialog.dart';
import 'package:get/get.dart';

import '../../../config/constants.dart';
import '../../../services/auth/auth_services.dart';
import '../../../widget/appBarWidget.dart';
import '../../home/home.dart';
import 'edit_profile_screen.dart';
import 'coordonates/my_contact_detail_screen.dart';

class ProfileScreen extends GetView<UserController> {
  const ProfileScreen({Key? key}) : super(key: key);

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
          title: 'Mon Profil',
        ),
        body: GetBuilder<UserController>(
          init: controller,
          builder: (controller) => Container(
            child: controller.isLoading.value
                ? const LoadingDialog()
                : controller.user.value.id == null
                    ? Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Aucune donnée, veuillez vous connecter",
                                style: TextStyle(color: AppTheme.darkColor)),
                            const SizedBox(
                              height: 20,
                            ),
                            // logout button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: AppTheme.redColor,
                              ),
                              onPressed: () async {
                                await AuthService().logout();
                              },
                              child: const Text('Déconnexion'),
                            ),
                          ],
                        ),
                      )
                    : ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: CircleAvatar(
                                    backgroundColor: AppTheme.darkColor,
                                    backgroundImage: NetworkImage(
                                      "${controller.user.value.photo}",
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: Get.width,
                                  child: Center(
                                    child: Text(
                                        '${controller.user.value.firstname} ${controller.user.value.lastname}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: AppTheme.darkColor,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w900)),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        await Get.to(() => EditProfileScreen());
                                        controller.setState();
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) =>
                                              states.contains(
                                                      MaterialState.disabled)
                                                  ? AppTheme.primaryColor
                                                  : AppTheme.redColor,
                                        ),
                                        overlayColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        )),
                                      ),
                                      child: Container(
                                        height: 20,
                                        width: Get.width / 3,
                                        child: Center(
                                          child: Text(
                                            'Modifier le profil',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 14,
                                                  color: AppTheme.light,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: Get.height / 4,
                                  width: Get.width - 50,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    color: AppTheme.light,
                                  ),
                                  child: TextFormField(
                                    enabled: false,
                                    controller:
                                        controller.descriptionController,
                                    //  key: AdPostView.descriptionFieldKey,
                                    maxLines: 15,
                                    style: TextStyle(color: AppTheme.darkColor),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 4.0, vertical: 3.0),
                                      filled: true,
                                      fillColor: AppTheme.light,
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            overflow: TextOverflow.visible,
                                            color: AppTheme.darkColor
                                                .withOpacity(0.5),
                                          ),
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0)),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  height: 40,
                                  color: AppTheme.darkColor,
                                ),
                                _createListMenu('Mes coordonnées',
                                    Routes.summaryCoordonate),
                                // _createListMenu('Porte-monnaie', MyContactDetailScreen()),
                                /*_createListMenu('Mes réseaux sociaux',
                                    SocialNetworkScreen()),*/
                                const SizedBox(
                                  height: 120,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.find<AuthService>().logout();
                                  },
                                  child: Container(
                                    height: 30,
                                    width: Get.width / 1.5,
                                    child: Center(
                                      child: Text(
                                        'Deconnexion',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 16,
                                              color: AppTheme.redColor,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
          ),
        ));
  }

  Widget _createListMenu(String menuTitle, String pageName) {
    return Container(
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
                            : AppTheme.light,
                  ),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  )),
                ),
                onPressed: () {
                  Get.toNamed(pageName);
                },
                child: SizedBox(
                  width: Get.width / 1.5,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(menuTitle,
                          style: TextStyle(
                              fontSize: 15, color: AppTheme.darkColor)),
                      Icon(Icons.arrow_forward_ios_outlined,
                          color: AppTheme.darkColor.withOpacity(0.9)),
                    ],
                  ),
                ))

            // Icon(Icons.chevron_right, size: 20, color: AppTheme.secondaryColor),
          ],
        ),
      ),
    );
  }
}
