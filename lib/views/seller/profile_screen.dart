import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/models/ProfileSeller.dart';
import 'package:get/get.dart';

import '../../models/Owner.dart';
import '../../widget/appBarWidget.dart';

class SellerProfileScreen extends StatelessWidget {
  final Owner seller;

  const SellerProfileScreen({Key? key, required this.seller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: CustomAppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios_outlined, color: AppTheme.darkColor,),),
        title: 'Profil',
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
                      backgroundImage: NetworkImage(
                        seller.photo!,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(seller.prenom!,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: AppTheme.darkColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w900)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        color: AppTheme.primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                          seller.isUserValidated == true
                              ? 'Profil recommandé'
                              : 'Pas recommandé',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  color: AppTheme.darkColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          color: AppTheme.primaryColor,
                        ),
                        child: Icon(
                          Icons.star,
                          color: AppTheme.backgroundColor,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(seller.prenom!.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  color: AppTheme.darkColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: Get.height / 2.5,
                    width: Get.width - 50,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: AppTheme.backgroundColor,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text(seller.prenom!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      color: AppTheme.darkColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700)),
                          Divider(
                            height: 40,
                            color: AppTheme.darkColor,
                          ),
                          Text('Membres depuis ${seller.registrationDate!}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      color: AppTheme.darkColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700)),
                          Divider(
                            height: 40,
                            color: AppTheme.darkColor,
                          ),
                          Text(
                              '${seller.success_reservation_count} locations déja effectuées',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      color: AppTheme.darkColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700)),
                          Divider(
                            height: 40,
                            color: AppTheme.darkColor,
                          ),
                          Text('${seller.success_reservation_count} véhicule en location',
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
                  SizedBox(
                    height: 20,
                  ),
                  _buildVehicle(context),
                  Container(
                    width: Get.width - 50,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 14),
                    child: Column(
                      children: [
                        Divider(
                          height: 40,
                          color: AppTheme.darkColor,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.share,
                                color: AppTheme.darkColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Partager le profil',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          color: AppTheme.darkColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.flag,
                                color: AppTheme.redColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Signaler le profil',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          color: AppTheme.darkColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicle(context) {
    return Card(
      color: AppTheme.backgroundColor,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: SizedBox(
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: Get.height / 5,
              width: Get.width / 1.57,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  repeat: ImageRepeat.noRepeat,
                  alignment: Alignment.topCenter,
                  image: AssetImage(seller.photo!),
                ),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
              ),
            ),
            Container(
              width: Get.width / 4,
              height: Get.height / 5,
              decoration: BoxDecoration(
                  color: AppTheme.darkColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${seller.prenom}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: AppTheme.backgroundColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700)),
                  Text('${seller.money} €',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: AppTheme.backgroundColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
