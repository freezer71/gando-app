import 'package:flutter/material.dart';
import 'package:gando/config/constants.dart';
import 'package:gando/helpers/global_function.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../config/textstyle.dart';
import '../../../controllers/car_controller.dart';
import 'demand_step/demand_booking_inprogress_screen.dart';
import 'demand_step/demand_booking_pending_screen.dart';
import 'demand_step/demand_booking_screen.dart';

class DemandTabScreen extends StatelessWidget {
  DemandTabScreen({Key? key}) : super(key: key);

  final gf = GlobalFunction();

  final controller = Get.put(CarController());


  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Locations à venir',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                color: AppTheme.darkColor),
          ),
          const SizedBox(
            height: 20,
          ),
          ..._buildBody(context),
        ],
      ),
    );
  }

  List<Widget> _buildBody(BuildContext context) => [
        InkWell(
          onTap: () {
            Get.to(() => DemandBookingScreen(car: carList.first,));
          },
          highlightColor: AppTheme.light,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            height: Get.height / 6,
            width: Get.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                // color: AppTheme.light,
                boxShadow: [
                  // BoxShadow(
                  //     color: AppTheme.darkColor.withOpacity(0.2),
                  //     offset: Offset(0.0, 0.0),
                  //     blurRadius: 6.0,
                  //     spreadRadius: 1,
                  //     blurStyle: BlurStyle.normal),
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 50,
                  width: 50,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/av.png'),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width / 1.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Get.width / 1.8,
                            child: Text(
                                'Demande de réservation en attente de votre reponse',
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        overflow: TextOverflow.clip,
                                        color: AppTheme.darkColor)),
                          ),
                          Container(
                            width: 10,
                            height: 10,
                            margin: const  EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                color: AppTheme.redColor,
                                borderRadius: BorderRadius.circular(50)
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: Get.width / 1.5,
                      child: Text('[nom prenom] souhaite\nlouer votre véhicule',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis,
                                  color: AppTheme.darkColor)),
                    ),
                    SizedBox(
                      width: Get.width / 1.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Du 22/12/2022',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      color: AppTheme.darkColor)),
                          Text('14/01/2023',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      color: AppTheme.darkColor)),
                          Text(gf.removeDecimalZeroFormat(300.0),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                      color: AppTheme.darkColor)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
    InkWell(
      onTap: () {
        Get.to(()=> DemandBookingPendingScreen(car: carList.first,));
      },
      highlightColor: AppTheme.light,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: Get.height / 6,
        width: Get.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 50,
                  width: 50,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/av.png'),
                  ),
                ).marginZero.paddingZero,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width / 1.6,
                      child: Text(
                          'Reservation\nen attente de reponse du propriétaire',
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                              color: AppTheme.darkColor)),
                    ),
                    SizedBox(
                      width: Get.width / 1.5,
                      child: Text('[nom prenom] souhaite\nlouer votre véhicule',
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                              color: AppTheme.darkColor)),
                    ),
                    SizedBox(
                      width: Get.width / 1.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Du 22/12/2022',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      color: AppTheme.darkColor)),
                          Text('14/01/2023',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      color: AppTheme.darkColor)),
                          Text(gf.removeDecimalZeroFormat(300.0),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                      color: AppTheme.darkColor)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 70,
        ),
        SizedBox(
          width: Get.width / 1.2,
          child: Text('Location en cours',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  overflow: TextOverflow.ellipsis,
                  color: AppTheme.darkColor)),
        ),
        InkWell(
          onTap: () {
            Get.to(() => DemandBookingInProgressScreen());
          },
          highlightColor: AppTheme.light,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            height: Get.height / 8,
            width: Get.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 50,
                      width: 50,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/av.png'),
                      ),
                    ).marginZero.paddingZero,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.width / 1.6,
                          child: Text('Laure Manida',
                              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                  color: AppTheme.darkColor)),
                        ),
                        SizedBox(
                          width: Get.width / 1.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Du 22/12/2022',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          overflow: TextOverflow.ellipsis,
                                          color: AppTheme.darkColor)),
                              Text('14/01/2023',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          overflow: TextOverflow.ellipsis,
                                          color: AppTheme.darkColor)),
                              Text(gf.removeDecimalZeroFormat(300.0),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 14,
                                          overflow: TextOverflow.ellipsis,
                                          color: AppTheme.darkColor)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      ];
}
