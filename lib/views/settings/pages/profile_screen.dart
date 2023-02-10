import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/models/ProfileSeller.dart';
import 'package:gando/views/settings/pages/social_network_screen.dart';
import 'package:get/get.dart';

import '../../../services/auth/auth_services.dart';
import '../../../widget/appBarWidget.dart';
import '../../home/home.dart';
import 'edit_profile_screen.dart';
import 'my_contact_detail_screen.dart';

class ProfileScreen extends GetView<AuthService> {
  final ProfileSeller seller;

  const ProfileScreen({Key? key, required this.seller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: CustomAppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios_outlined, color: AppTheme.darkColor,),),
        title: 'Mon Profil',
      ),
      body: Container(
        child: ListView(
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
                      backgroundColor: AppTheme.backgroundColor,
                      backgroundImage: AssetImage(
                        seller.image,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(seller.name,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: AppTheme.darkColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w900)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => Get.to(() => EditProfileScreen(seller: seller,)),
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) =>
                            states.contains(MaterialState.disabled)
                                ? AppTheme.primaryColor
                                : AppTheme.redColor,
                          ),
                          overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )),
                        ),
                        child: Container(
                          height: 20,
                          width: Get.width / 3,
                          child: Center(
                            child: Text('Modifier le profil', style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: AppTheme.light,
                            ),),
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
                        vertical: 14, horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: AppTheme.light,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text(seller.description,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                  color: AppTheme.darkColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 40,
                    color: AppTheme.darkColor,
                  ),
                  _createListMenu('Mes coordonnées', MyContactDetailScreen()),
                  // _createListMenu('Porte-monnaie', MyContactDetailScreen()),
                  _createListMenu('Mes réseaux sociaux', SocialNetworkScreen()),
                  const SizedBox(
                    height: 120,
                  ),
                  InkWell(
                    onTap: (){
                      controller.logout();
                    },
                    child: Container(
                      height: 30,
                      width: Get.width / 1.5,
                      child: Center(
                        child: Text('Deconnexion', style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: AppTheme.redColor,
                        ),),
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
    );
  }

  Widget _createListMenu(String menuTitle, StatelessWidget page) {
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
                  Get.to(() => page);
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
