import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/models/profile_seller.dart';
import 'package:get/get.dart';

class SellerProfileScreen extends StatelessWidget {
  final ProfileSeller seller;
  const SellerProfileScreen({Key? key, required this.seller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(
          'Profil',
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 18,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: Container(child:
        ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(height: 20,),
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
                  SizedBox(height: 20,),
                  Text(seller.name,  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w900)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check, color: AppTheme.primaryColor,),
                      SizedBox(width: 10,),
                      Text(seller.isRecommended ? 'Profil recommandé' : 'Pas recommandé',  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: AppTheme.darkColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500))
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: AppTheme.primaryColor,
                        ),
                        child: Icon(
                          Icons.star,
                          color: AppTheme.backgroundColor,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(seller.rate, style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: AppTheme.darkColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500))
                    ],
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: Get.height / 2.5,
                    width: Get.width - 50,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: AppTheme.backgroundColor,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text(seller.description, style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: AppTheme.darkColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w700)),
                          Divider(height: 40, color: AppTheme.darkColor,),
                          Text('Membres depuis ${seller.createdAt.year}', style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: AppTheme.darkColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w700)),
                          Divider(height: 40, color: AppTheme.darkColor,),
                          Text('${seller.bookingCount} locations déja effectuées', style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: AppTheme.darkColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w700)),
                          Divider(height: 40, color: AppTheme.darkColor,),
                          Text('${seller.garage} véhicule en location', style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: AppTheme.darkColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w700)),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  _buildVehicle(context),
                  Container(
                    width: Get.width - 50,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    child: Column(
                      children: [
                        Divider(height: 40, color: AppTheme.darkColor,),
                        InkWell(
                          onTap: (){},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.share, color: AppTheme.darkColor,),
                              SizedBox(width: 10,),
                              Text('Partager le profil', style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                  color: AppTheme.darkColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500))
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        InkWell(
                          onTap: (){},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.flag, color: AppTheme.redColor,),
                              SizedBox(width: 10,),
                              Text('Signaler le profil',  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                  color: AppTheme.darkColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 200,),
                ],
              ),
            ),

          ],
        ),),
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
            SizedBox(
              width: Get.width / 22,
            ),
            Container(
              height: Get.height / 5,
              width: Get.width / 2,
              decoration: BoxDecoration(

                image: DecorationImage(
                  repeat: ImageRepeat.noRepeat,
                  alignment: Alignment.center,
                  image:
                  AssetImage(seller.cars[0].image),
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            Container(
              width: Get.width / 3,
              height: Get.height / 5,
              decoration: BoxDecoration(
                  color: AppTheme.darkColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${seller.cars[0].brand} \n ${seller.cars[0].model}', textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppTheme.backgroundColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700)),
                  Text('${seller.cars[0].price} €', textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText2!.copyWith(
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
