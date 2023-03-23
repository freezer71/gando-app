import 'package:flutter/material.dart';
import 'package:gando/config/config.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/user/user_controller.dart';
import 'package:gando/models/ProfileSeller.dart';
import 'package:gando/models/User.dart';
import 'package:gando/views/settings/pages/social_network_screen.dart';
import 'package:get/get.dart';

import '../../../config/constants.dart';
import '../../../services/auth/auth_services.dart';
import '../../../widget/appBarWidget.dart';
import '../../home/home.dart';
import 'edit_profile_screen.dart';
import 'my_contact_detail_screen.dart';

class ProfileScreen extends GetView<UserController> {
  final ProfileSeller seller;

  ProfileScreen({Key? key, required this.seller}) : super(key: key);

  late User user;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => UserController());

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: CustomAppBar(
        leading: IconButton(onPressed: () {
          Get.back();
        },
          icon: Icon(
            Icons.arrow_back_ios_outlined, color: AppTheme.darkColor,),),
        title: 'Mon Profil',
      ),
      body: Container(
        child: GetBuilder<UserController>(
          assignId: true,
          autoRemove: false,
          builder: (logic) {
            return FutureBuilder<User>(
              future: logic.getUserProfile,
              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                // all state of snapshot
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                 if(snapshot.hasData){
                   if(snapshot.data != null) {
                     user = snapshot.data!;
                     return ListView(
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
                                     user.photo!,
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
                                       '${user.firstname!} ${user.lastname!}',
                                       style: Theme
                                           .of(context)
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
                                     onPressed: () =>
                                         Get.to(() =>
                                             EditProfileScreen(seller: seller,)),
                                     style: ButtonStyle(
                                       backgroundColor:
                                       MaterialStateProperty.resolveWith<Color>(
                                             (Set<MaterialState> states) =>
                                         states.contains(MaterialState.disabled)
                                             ? AppTheme.primaryColor
                                             : AppTheme.redColor,
                                       ),
                                       overlayColor:
                                       MaterialStateProperty.all(
                                           Colors.transparent),
                                       shape: MaterialStateProperty.all(
                                           RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(
                                                 30.0),
                                           )),
                                     ),
                                     child: Container(
                                       height: 20,
                                       width: Get.width / 3,
                                       child: Center(
                                         child: Text(
                                           'Modifier le profil', style: Theme
                                             .of(context)
                                             .textTheme
                                             .bodyText2!
                                             .copyWith(
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
                                   borderRadius: const BorderRadius.all(
                                       Radius.circular(20)),
                                   color: AppTheme.light,
                                 ),
                                 child: Center(
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       Text(user.status!,
                                           style: Theme
                                               .of(context)
                                               .textTheme
                                               .bodyText2!
                                               .copyWith(
                                               color: AppTheme.darkColor,
                                               fontSize: 14,
                                               fontWeight: FontWeight.w700)),
                                       const SizedBox(
                                         height: 10,
                                       ),
                                       Text('${user.status!}, ${user.status!}, ${user.status!}, ${user.status!}',
                                           style: Theme
                                               .of(context)
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
                               _createListMenu(
                                   'Mes coordonnées', MyContactDetailScreen()),
                               // _createListMenu('Porte-monnaie', MyContactDetailScreen()),
                               _createListMenu(
                                   'Mes réseaux sociaux', SocialNetworkScreen()),
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
                                     child: Text('Deconnexion', style: Theme
                                         .of(context)
                                         .textTheme
                                         .bodyText2!
                                         .copyWith(
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
                     );
                   } else {
                     return const Center(child: Text('Error'));
                   }
                  }else{
                   return const Center(child: Text('Error'));
                 }
                } else {
                  return const Center(child: Text('Error'));
                }
              },
            );
          },
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
