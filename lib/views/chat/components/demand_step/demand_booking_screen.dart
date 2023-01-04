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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: SizedBox(
              height: 40,
              width: 40,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/av.png'),
              ),
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
                  '[Laure Manida] souhaite louer votre véhicule\n${car.brand} ${car.model}' ,
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
                  '${car.price * 50 / 100} €'.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: AppTheme.darkColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Get.height / 4,),
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
