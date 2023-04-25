import 'dart:io';

import 'package:csc_picker/csc_picker.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gando/config/constants.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/views/home/home.dart';
import 'package:get/get.dart';
import 'package:text_form_field_wrapper/text_form_field_wrapper.dart';

import '../../../../models/Car.dart';
import '../../../../widget/appBarWidget.dart';
import '../../../../widget/customTextFormField.dart';
import '../../../products/booking/contract/contract_step_2.dart';
import '../../../products/booking/success_booking_screen.dart';

class DemandBookingScreen extends StatefulWidget {
  final car;

  DemandBookingScreen({Key? key, required this.car}) : super(key: key);

  @override
  State<DemandBookingScreen> createState() => _DemandBookingScreenState();
}

class _DemandBookingScreenState extends State<DemandBookingScreen> {
  final TextEditingController etNameController = TextEditingController();

  final TextEditingController etLastNameController = TextEditingController();

  final TextEditingController drivingIdController = TextEditingController();

  final TextEditingController obtainingDateController = TextEditingController();

  String obtainingCountryController = 'Pays d\'obtention';

  final formKey = GlobalKey<FormState>();
  final key = GlobalKey<FormState>();

  late Car car;

  @override
  void initState() {
    super.initState();
    car = widget.car;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor.withOpacity(0.9),
      appBar: CustomAppBar(
        leading: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 0,
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: AppTheme.darkColor,
                ),
              ),
            ),
            const Positioned(
              right: -40,
              top: 8,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/av.png'),
              ),
            )
          ],
        ),
        title: 'Laure Manida',
        action: [
          InkWell(
            onTap: () {
              Get.bottomSheet(_buildBottomSheet(car));
            },
            child: Container(
              width: 30,
              height: 5,
              margin: const EdgeInsets.only(top: 8, bottom: 8, right: 18),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppTheme.light.withOpacity(0.4)),
              child: Center(
                  child: Icon(
                Icons.more_vert_outlined,
                color: AppTheme.darkColor,
              )),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  '[Laure Manida] souhaite louer votre véhicule\n${car.brand} ${car.model}',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: AppTheme.darkColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                  textAlign: TextAlign.center,
                ),
                Divider(
                  height: Get.height / 22,
                  color: AppTheme.darkColor,
                ),
                _buildRowMenu(),
                Divider(
                  height: Get.height / 12,
                  color: AppTheme.darkColor,
                ),
                ..._buildBody(),
                SizedBox(
                  height: Get.height / 22,
                ),
                Text(
                  'Vous recevrez pour cette location',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: AppTheme.darkColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${car.pricePerDay! * 50 / 100} €'.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: AppTheme.darkColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Get.height / 4,
                ),
              ],
            ),
          ),
          _buildFloatBar(),
        ],
      ),
    );
  }

  Widget _buildBottomSheet(Car car) {
    return Container(
      width: Get.width,
      height: 400,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(22),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.phone_enabled_rounded,
                        color: AppTheme.darkColor.withOpacity(0.7),
                      ),
                      Text("Voir le numéro",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: AppTheme.darkColor,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                    ],
                  ),
                ),
                Divider(
                  color: AppTheme.darkColor.withOpacity(0.3),
                ),
                Container(
                  padding: EdgeInsets.all(22),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.message,
                        color: AppTheme.darkColor.withOpacity(0.7),
                      ),
                      Text("Envoyer un message",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: AppTheme.darkColor,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                    ],
                  ),
                ),
                Divider(
                  color: AppTheme.darkColor.withOpacity(0.3),
                ),
                Container(
                  padding: EdgeInsets.all(22),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.share,
                        color: AppTheme.darkColor.withOpacity(0.7),
                      ),
                      Text("Partager le profile",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: AppTheme.darkColor,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                    ],
                  ),
                ),
                Divider(
                  color: AppTheme.darkColor.withOpacity(0.3),
                ),
                Container(
                  padding: EdgeInsets.all(22),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.flag,
                        color: AppTheme.darkColor.withOpacity(0.7),
                      ),
                      Text("Signaler le profil",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: AppTheme.darkColor,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: -15,
              right: -15,
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.close,
                  color: AppTheme.darkColor,
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildFloatBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: AppTheme.light,
        ),
        height: Platform.isAndroid ? 70 : 90,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: _buildBodyButtons(),
      ),
    );
  }

  Widget _buildRowMenu() {
    return Container(
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Départ'.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: AppTheme.darkColor.withOpacity(.5),
                            fontSize: 18,
                            fontWeight: FontWeight.w900)),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  height: Get.height / 5,
                  width: Get.width / 2.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Lundi',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  color: AppTheme.darkColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900)),
                      Text('09',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  color: AppTheme.darkColor,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900)),
                      Text('Septembre',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  color: AppTheme.darkColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900)),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: AppTheme.darkColor,
                        ),
                        child: Text('14 : 30',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    color: AppTheme.backgroundColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Retour'.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: AppTheme.darkColor.withOpacity(0.5),
                            fontSize: 18,
                            fontWeight: FontWeight.w900)),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  height: Get.height / 5,
                  width: Get.width / 2.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Jour',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  color: AppTheme.darkColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900)),
                      Text('XX',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  color: AppTheme.darkColor,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900)),
                      Text('Mois',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  color: AppTheme.darkColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900)),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: AppTheme.darkColor,
                        ),
                        child: Text('12 : 00',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    color: AppTheme.backgroundColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildBody() {
    return [
      Container(
        width: Get.width / 22,
        child: Column(
          children: [
            Text('Adresse de départ et de retour',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: AppTheme.darkColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_pin,
                  color: AppTheme.darkColor,
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('11 Adile Maret Sainte-Anne, 97180',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: AppTheme.darkColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w900)),
                    Text('Click for directions',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: AppTheme.darkColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
            Divider(
              height: Get.height / 12,
              color: AppTheme.darkColor,
            ),
          ],
        ),
      )
    ];
  }

  Widget _buildBodyButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.width / 2.3,
          height: 48,
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: const BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(29)),
            color: Colors.transparent,
          ),
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(29)),
            // splashColor: const Color(0xFFEEEEEE),
            onTap: () => Get.back(),
            child: Center(
              child: Text(
                'Refuser'.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppTheme.redColor,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 48,
          margin: EdgeInsets.symmetric(vertical: 10),
          width: Get.width / 2.3,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(29)),
            color: AppTheme.primaryColor,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(29)),
              // splashColor: const Color(0xFFEEEEEE),
              onTap: () {
                //open bottom sheet
                Get.to(() => ContractStep2());
              },
              child: Center(
                child: Text(
                  'ACCEPTER'.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppTheme.light,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
