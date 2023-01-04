import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/models/profile_seller.dart';
import 'package:get/get.dart';

import '../../home/home.dart';
import 'edit_profile_screen.dart';

class ContactScreen extends StatelessWidget {
  final ProfileSeller seller;

  const ContactScreen({Key? key, required this.seller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_outlined),
          color: AppTheme.darkColor,
        ),
        title: Text(
          'Mon Profil',
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 18,
            color: AppTheme.darkColor,
            overflow: TextOverflow.ellipsis,
          ),
        ),
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
                  SizedBox(
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
                          height: 30,
                          width: Get.width / 1.5,
                          child: Center(
                            child: Text('Modifier le profil', style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
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
                  _createListMenu('Mes coordonnées', EditProfileScreen(seller: seller,)),
                  _createListMenu('Porte-monnaie', EditProfileScreen(seller: seller,)),
                  _createListMenu('Mes réseaux sociaux', EditProfileScreen(seller: seller,)),
                  const SizedBox(
                    height: 120,
                  ),
                  TextButton(
                    onPressed: () => Get.back(),
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
                      height: 30,
                      width: Get.width / 1.5,
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Deconnexion', style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: AppTheme.light,
                            ),),
                            const SizedBox(
                              width: 20,
                            ),
                            Icon(Icons.exit_to_app_outlined,
                                color: AppTheme.light.withOpacity(0.9)),
                          ],
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
