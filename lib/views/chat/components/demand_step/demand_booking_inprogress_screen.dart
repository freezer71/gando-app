import 'package:csc_picker/csc_picker.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gando/config/constants.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/views/home/home.dart';
import 'package:get/get.dart';
import 'package:text_form_field_wrapper/text_form_field_wrapper.dart';

import '../../../../models/car.dart';
import '../../../../widget/customTextFormField.dart';
import '../../../products/booking/contract/contract_step_1.dart';
import '../../../products/booking/contract/contract_step_2.dart';
import '../../../products/booking/success_booking_screen.dart';

class DemandBookingInProgressScreen extends StatefulWidget {
  final car;
  DemandBookingInProgressScreen({Key? key, required this.car}) : super(key: key);

  @override
  State<DemandBookingInProgressScreen> createState() => _DemandBookingInProgressScreenState();
}

class _DemandBookingInProgressScreenState extends State<DemandBookingInProgressScreen> {
  final TextEditingController etNameController = TextEditingController();

  final TextEditingController etLastNameController = TextEditingController();

  final TextEditingController drivingIdController = TextEditingController();

  final TextEditingController obtainingDateController = TextEditingController();

  String obtainingCountryController = 'Pays d\'obtention';

  final formKey = Get.key;
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: AppTheme.darkColor,
          ),
        ),
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: SizedBox(
              height: 40,
              width: 40,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/av.png'),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              Get.bottomSheet(_buildBottomSheet(car));
            },
            child: Container(
              width: 30,
              height: 5,
              margin: const EdgeInsets.only(top: 8, bottom: 8, right: 18),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppTheme.light.withOpacity(0.4)
              ),
              child: Center(child: Icon(Icons.more_vert_outlined, color: AppTheme.darkColor,)),
            ),
          ),
        ],
        title: SizedBox(
          width: Get.width,
          child: Text('Laure Manida',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                overflow: TextOverflow.ellipsis,
                color: AppTheme.darkColor), textAlign: TextAlign.center,),
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  '${car.brand} ${car.model}' ,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
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
                  height: Get.height / 22,
                  color: AppTheme.darkColor,
                ),
                ..._buildBody(),

                Text(
                  'Le montant de la location est de ',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: AppTheme.darkColor,
                    overflow: TextOverflow.ellipsis,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${car.price * 30 / 100} €'.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: AppTheme.darkColor,
                    overflow: TextOverflow.ellipsis,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: Get.width,
                  // padding: const EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: 40),
                  decoration: BoxDecoration(
                    color: AppTheme.light.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: InkWell(
                    onTap: () {
                      // open file in pdf viewer;
                      Get.to(()=> const ContractStep1());
                    },
                    splashColor: AppTheme.primaryColor,
                    highlightColor: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: Get.height / 28,
                            child: Text(
                              'Ouvrir le contrat de location',
                              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                color: AppTheme.darkColor,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 3,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Icon(Icons.assignment,size: 40, color: AppTheme.darkColor.withOpacity(0.4),),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: Get.height / 5,)
              ],
            ),
          ),
          _buildFloatBar(),
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
        color: Colors.white,
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: _buildBodyButtons(),
      ),
    );
  }

  Widget _buildBottomSheet(Car car) {
    return Container(
      width: Get.width,
      height: 400,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color:  AppTheme.backgroundColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
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
                      Icon(Icons.phone_enabled_rounded, color: AppTheme.darkColor.withOpacity(0.7),),
                      Text("Voir le numéro", style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppTheme.darkColor,
                        overflow: TextOverflow.ellipsis,
                      )),
                    ],
                  ),
                ),
                Divider( color: AppTheme.darkColor.withOpacity(0.3),),
                Container(
                  padding: EdgeInsets.all(22),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.message, color: AppTheme.darkColor.withOpacity(0.7),),
                      Text("Envoyer un message", style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppTheme.darkColor,
                        overflow: TextOverflow.ellipsis,
                      )),
                    ],
                  ),
                ),
                Divider( color: AppTheme.darkColor.withOpacity(0.3),),
                Container(
                  padding: EdgeInsets.all(22),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.share, color: AppTheme.darkColor.withOpacity(0.7),),
                      Text("Partager le profile", style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppTheme.darkColor,
                        overflow: TextOverflow.ellipsis,
                      )),
                    ],
                  ),
                ),
                Divider( color: AppTheme.darkColor.withOpacity(0.3),),
                Container(
                  padding: EdgeInsets.all(22),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.flag, color: AppTheme.darkColor.withOpacity(0.7),),
                      Text("Signaler le profil", style: Theme.of(context).textTheme.bodyText2!.copyWith(
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
              child: IconButton(onPressed: (){
                Get.back();
              }, icon: Icon(Icons.close, color: AppTheme.darkColor,),))
        ],
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
                    child: Text('Départ',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: AppTheme.darkColor,
                            fontSize: 16,
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
                    child: Text('Retour',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: AppTheme.darkColor,
                            fontSize: 16,
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
    return Container(
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
            'Annuler la location'.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppTheme.redColor,
            ),
          ),
        ),
      ),
    );
  }
}
