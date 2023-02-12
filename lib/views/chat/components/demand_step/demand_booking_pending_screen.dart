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

class DemandBookingPendingScreen extends StatefulWidget {
  final car;
  DemandBookingPendingScreen({Key? key, required this.car}) : super(key: key);

  @override
  State<DemandBookingPendingScreen> createState() => _DemandBookingPendingScreenState();
}

class _DemandBookingPendingScreenState extends State<DemandBookingPendingScreen> {
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
      appBar: CustomAppBar(
        leading: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 0,
              child: IconButton(onPressed: (){
                Get.back();
              }, icon: Icon(Icons.arrow_back_ios_outlined, color: AppTheme.darkColor,),),),
            const Positioned(
              right: -40,
              top: 8,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/av.png'),
              ),)
          ],
        ),
        title: 'Laure Manida',
        action: [
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
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: AppTheme.light,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.access_time_outlined, color: AppTheme.darkColor.withOpacity(0.4),),
                  SizedBox(
                    width: Get.width /20,),
                      SizedBox(
                        width: Get.width / 1.6,
                        child: Text(
                          'Votre demande de location est désormais en attente\n de la réponse du propriétaire.',
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: AppTheme.darkColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 3,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height / 5,),
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

  Widget _buildFloatBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: AppTheme.light,
        ),
        height: Platform.isAndroid ? 70 : 90,
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
              height: Get.height / 22,
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
      margin: const EdgeInsets.only(bottom: 18),
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
            'Annuler la demande'.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppTheme.redColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection1(BuildContext context) {
    return SizedBox(
      height: Get.height / 0.93,
      child: Column(
        children: [
          SizedBox(
            child: Form(
              key: key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    verticalDirection: VerticalDirection.down,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 180,
                        child: CustomTextFormField(
                          controller: etNameController,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          enabled: true,
                          validator: (v) { return null;  },
                          onChanged: (v) {  },
                          onSaved: (v) {  }, hintText: 'Nom', formatter: [],
                        ),
                      ),
                      Container(
                        width: 180,
                        child: CustomTextFormField(
                          controller: etLastNameController,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          enabled: true,
                          validator: (v) { return null;  },
                          onChanged: (v) {  },
                          onSaved: (v) {  }, hintText: 'Prénom', formatter: [],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: Get.width - 40,
                    padding: EdgeInsets.only(bottom: 10, top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pays D\'obtention',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                              color: AppTheme.darkColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CSCPicker(
                          showCities: false,
                          showStates: false,
                          countryDropdownLabel: obtainingCountryController,
                          defaultCountry: CscCountry.France,
                          flagState: CountryFlag.DISABLE,
                          selectedItemStyle: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                              color: AppTheme.darkColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                          dropdownDecoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                              color: AppTheme.light,
                              border: Border.all(
                                  color: AppTheme.darkColor, width: 2)),
                          countrySearchPlaceholder: "Selectionner un Pays",
                          ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                          disabledDropdownDecoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                              color: Colors.grey.shade300,
                              border: Border.all(
                                  color: AppTheme.darkColor.withOpacity(0.4), width: 1)),
                          dropdownItemStyle: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                              color: AppTheme.backgroundColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                          onCountryChanged: (value) {
                            setState(() {
                              obtainingCountryController = value;
                            });

                            printInfo(info: obtainingCountryController);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width - 40,
                    padding: EdgeInsets.only(bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Numéro de Permis',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                color: AppTheme.darkColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          controller: drivingIdController,
                          keyboardType: TextInputType.number,
                          autofocus: false,
                          validator: (v) { return null;  },
                          onChanged: (v) {  },
                          onSaved: (v) {  }, hintText: 'Numero de permis', formatter: [],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width - 40,
                    padding: const  EdgeInsets.only(bottom: 10, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date D\'obtention',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                              color: AppTheme.darkColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //
                        DropdownDatePicker(
                          inputDecoration: InputDecoration(
                            filled: true,
                            fillColor: AppTheme.light,
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppTheme.darkColor, width: 1.0),
                              borderRadius: BorderRadius.circular(30),
                              gapPadding: 0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppTheme.darkColor, width: 1.0),
                              borderRadius: BorderRadius.circular(30),
                              gapPadding: 0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              gapPadding: 0,
                            ),
                          ),
                          // optional
                          isDropdownHideUnderline: true,
                          // optional
                          isFormValidator: true,
                          // optional
                          startYear:
                          DateTime.parse('1969-07-20 20:18:04Z').year,
                          // optional
                          endYear: DateTime.now().year,
                          // optional
                          width: 2,
                          // optional
                          selectedDay: DateTime.now().day,
                          // optional
                          // selectedMonth: 12, // optional
                          selectedYear: DateTime.now().year,
                          selectedMonth: DateTime.now().month,
                          showMonth: true,
                          // optional
                          onChangedDay: (value) =>
                              print('onChangedDay: $value'),
                          onChangedMonth: (value) =>
                              print('onChangedMonth: $value'),
                          onChangedYear: (value) =>
                              print('onChangedYear: $value'),
                          boxDecoration: BoxDecoration(
                              border: Border.all(color: Colors.transparent, width: 0.0)), // optional
                          showDay: true,// optional
                          dayFlex: 2,
                          locale: "en",// optional
                          hintDay: 'Jour', // optional
                          hintMonth: 'Mois', // optional
                          hintYear: 'Année', // optional
                          hintTextStyle: TextStyle(color: AppTheme.redColor, fontSize: 9), // optional
                        ),

                        // TextButton(
                        //     style: ButtonStyle(
                        //       backgroundColor:
                        //           MaterialStateProperty.resolveWith<Color>(
                        //         (Set<MaterialState> states) =>
                        //             states.contains(MaterialState.disabled)
                        //                 ? AppTheme.primaryColor
                        //                 : AppTheme.backgroundColor,
                        //       ),
                        //       overlayColor:
                        //           MaterialStateProperty.all(Colors.transparent),
                        //       shape: MaterialStateProperty.all(
                        //         RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(10.0),
                        //         ),
                        //       ),
                        //     ),
                        //     onPressed: () async {
                        //       Get.dialog(DatePickerDialog(
                        //           initialDate: DateTime.now(),
                        //           firstDate: DateTime.now(),
                        //           lastDate: DateTime.now()));
                        //     },
                        //     child: SizedBox(
                        //       width: Get.width,
                        //       height: 30,
                        //       child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         children: [
                        //           Text('Date du D\'obtention',
                        //               style: Theme.of(context)
                        //                   .textTheme
                        //                   .bodyText2!
                        //                   .copyWith(
                        //                       color: AppTheme.darkColor,
                        //                       fontSize: 16,
                        //                       fontWeight: FontWeight.w500)),
                        //           Icon(
                        //             Icons.calendar_month,
                        //             color: AppTheme.darkColor,
                        //           )
                        //         ],
                        //       ),
                        //     )),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: Get.height / 12,
            color: AppTheme.darkColor,
          ),
          _buildResultForm(context),
        ],
      ),
    );
  }

  Widget _buildResultForm(BuildContext context) {
    if (1==1) { // ramplace with current form state validator check
      return Container(
        height: Get.height / 2.2,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(29)),
          color: AppTheme.backgroundColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(4, 8),
              blurRadius: 20,
              color: const Color(0xFF101010).withOpacity(0.25),
            ),
          ],
        ),

        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Text('Detail de la location ',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: AppTheme.darkColor,
                  overflow: TextOverflow.ellipsis,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Durée de la location',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppTheme.darkColor,
                        overflow: TextOverflow.ellipsis,
                      )),
                  Text('1 jour',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: AppTheme.darkColor,
                        overflow: TextOverflow.ellipsis,
                      )),
                ],
              ),
            ),
            Divider(
              height: 10,
              color: AppTheme.darkColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Kilometrage inclus',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppTheme.darkColor,
                        overflow: TextOverflow.ellipsis,
                      )),
                  Text('200 Km',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: AppTheme.darkColor,
                        overflow: TextOverflow.ellipsis,
                      )),
                ],
              ),
            ),
            Divider(
              height: 10,
              color: AppTheme.darkColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Montant (hors option)',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppTheme.darkColor,
                        overflow: TextOverflow.ellipsis,
                      )),
                  Text('15 €',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: AppTheme.darkColor,
                        overflow: TextOverflow.ellipsis,
                      )),
                ],
              ),
            ),
            Divider(
              height: 10,
              color: AppTheme.darkColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Suplément jeune conducteur',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppTheme.darkColor,
                        overflow: TextOverflow.ellipsis,
                      )),
                  Text('2.25 €',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: AppTheme.darkColor,
                        overflow: TextOverflow.ellipsis,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Montant total',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: AppTheme.darkColor,
                        overflow: TextOverflow.ellipsis,
                      )),
                  Text('17.25 € ',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                        color: AppTheme.primaryColor,
                        overflow: TextOverflow.ellipsis,
                      )),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
