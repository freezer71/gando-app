import 'package:csc_picker/csc_picker.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gando/config/constants.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/views/home/home.dart';
import 'package:get/get.dart';
import 'package:text_form_field_wrapper/text_form_field_wrapper.dart';

import '../../../models/car.dart';
import '../../../widget/appBarWidget.dart';
import '../../../widget/customTextFormField.dart';
import 'payment/payment_screen.dart';
import 'success_booking_screen.dart';

class BookingScreen extends StatefulWidget {
  final car;
  BookingScreen({Key? key, required this.car}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
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
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios_outlined, color: AppTheme.darkColor,),),
        title: 'Réserver le véhicule',
      ),
      body: Stack(
        children: [
          Container(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildRowMenu(context),
                Divider(
                  height: Get.height / 12,
                  color: AppTheme.darkColor,
                ),
                ..._buildBody(context),
                SizedBox(
                  height: Get.height / 8,
                )
              ],
            ),
          ),
          _buldFloatBar(),
        ],
      ),
    );
  }

  Widget _buldFloatBar() {
    buildAddCard() => Container(
          height: 58,
          width: Get.width / 1.2,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(29)),
            color: AppTheme.primaryColor,
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 8),
                blurRadius: 20,
                color: const Color(0xFF101010).withOpacity(0.25),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(29)),
              // splashColor: const Color(0xFFEEEEEE),
              onTap: () {
                //got to next page
                Get.bottomSheet(_buildBottomSheet(context, car));
              },
              child: Center(
                child: Text(
                  'Réserver'.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildAddCard(),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () {
                    // go to signalisation page
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.flag,
                        color: AppTheme.redColor,
                      ),
                      const Text('Signaler l\'annonce',
                          style: TextStyle(
                              color: Color(0xFF757575), fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
            // const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBottomSheet(BuildContext context, Car car) {
    bookingButton() => Container(
      height: 58,
      margin: EdgeInsets.symmetric(vertical: 10),
      width: Get.width / 1.2,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(29)),
        color: AppTheme.primaryColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(4, 8),
            blurRadius: 20,
            color: const Color(0xFF101010).withOpacity(0.25),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(29)),
          // splashColor: const Color(0xFFEEEEEE),
          onTap: () {
            //open bottom sheet
            Get.bottomSheet(_buildPaymentBottomSheet(context, car));
          },
          child: Center(
            child: Text(
              'Réserver'.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );

    return Container(
      width: Get.width,
      height: 350,
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
                Text("${car.brand} ${car.model}", style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: AppTheme.darkColor,
                  overflow: TextOverflow.ellipsis,
                )),
                Divider(color: AppTheme.darkColor.withOpacity(0.3),),
                Container(
                  padding: EdgeInsets.all(22),
                  child: Text("11 adile maret Sainte Anne, 97180", style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppTheme.darkColor,
                    overflow: TextOverflow.ellipsis,
                  )),
                ),
                Divider( color: AppTheme.darkColor.withOpacity(0.3),),
                Container(
                  width: Get.width / 1.4,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("du 11/09/22", style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: AppTheme.darkColor,
                            overflow: TextOverflow.ellipsis,
                          )),
                          Text("à 14h30", style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: AppTheme.darkColor,
                            overflow: TextOverflow.ellipsis,
                          )),
                        ],
                      ),
                      Column(
                        children: [
                          Text("du 02/09/22", style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: AppTheme.darkColor,
                            overflow: TextOverflow.ellipsis,
                          )),
                          Text("à 14h30", style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: AppTheme.darkColor,
                            overflow: TextOverflow.ellipsis,
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider( color: AppTheme.darkColor.withOpacity(0.3),),
                bookingButton(),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text("Ajouter un code promotionnel", style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppTheme.primaryColor,
                    overflow: TextOverflow.ellipsis,
                  )),
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
  Widget _buildPaymentBottomSheet(BuildContext context, Car car) {
    bookingButton() => Container(
      height: 58,
      margin: EdgeInsets.symmetric(vertical: 10),
      width: Get.width / 1.2,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(29)),
        color: AppTheme.darkColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(4, 8),
            blurRadius: 20,
            color: const Color(0xFF101010).withOpacity(0.25),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(29)),
          // splashColor: const Color(0xFFEEEEEE),
          onTap: () {
            //open bottom sheet
            Get.bottomSheet(_buildOtherPaymentBottomSheet(context, car));
          },
          child: Center(
            child: Text(
              'Paiement'.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
    return Container(
      width: Get.width,
      height: 450,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color:  AppTheme.backgroundColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            child: Column(
              children: [
                Text("${car.brand} ${car.model}", style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: AppTheme.darkColor,
                  overflow: TextOverflow.ellipsis,
                )),
                Text("Marco DEGARDIO", style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppTheme.darkColor,
                  overflow: TextOverflow.ellipsis,
                )),
                Divider(color: AppTheme.darkColor.withOpacity(0.3),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Prix jour',
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AppTheme.darkColor,
                            overflow: TextOverflow.ellipsis,
                          )),
                      Text('15 €',
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            color: AppTheme.darkColor,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ],
                  ),
                ),
                Divider( color: AppTheme.darkColor.withOpacity(0.3),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Suplément jeune conducteur',
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AppTheme.darkColor,
                            overflow: TextOverflow.ellipsis,
                          )),
                      Text('2,25 €',
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            color: AppTheme.darkColor,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ],
                  ),
                ),
                Divider( color: AppTheme.darkColor.withOpacity(0.3),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Promotion',
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AppTheme.darkColor,
                            overflow: TextOverflow.ellipsis,
                          )),
                      Text('-0,00 €',
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            color: AppTheme.darkColor,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ],
                  ),
                ),
                Divider( color: AppTheme.darkColor.withOpacity(0.3),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total',
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            color: AppTheme.darkColor,
                            overflow: TextOverflow.ellipsis,
                          )),
                      Text('17,25 €',
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: AppTheme.darkColor,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ],
                  ),
                ),
                Divider( color: AppTheme.darkColor.withOpacity(0.3),),
                Text("En reservant  véhicule,vous acceptez les \nconditons générales de Gando", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppTheme.darkColor,
                  overflow: TextOverflow.ellipsis,
                )),
                bookingButton(),
                Container(
                  padding: EdgeInsets.all(4),
                  child: Text("Autres moyens de paiement".toUpperCase(), style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: AppTheme.darkColor,
                    overflow: TextOverflow.ellipsis,
                  )),
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
  Widget _buildOtherPaymentBottomSheet(BuildContext context, Car car) {
    bookingButton({String? title, Color? color}) => Container(
      height: 58,
      margin: EdgeInsets.symmetric(vertical: 10),
      width: Get.width / 1.2,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(29)),
        color: color,
        boxShadow: [
          BoxShadow(
            offset: const Offset(4, 8),
            blurRadius: 20,
            color: const Color(0xFF101010).withOpacity(0.25),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(29)),
          // splashColor: const Color(0xFFEEEEEE),
          onTap: () {
            //open bottom sheet
            Get.to(() => const SuccessBookingScreen());
          },
          child: Center(
            child: Text(
              title!.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
    return Container(
      width: Get.width,
      height: 250,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color:  AppTheme.backgroundColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                bookingButton(title: 'Carte bancaire', color: AppTheme.primaryColor),
                bookingButton(title: 'PayPal', color: AppTheme.darkColor),
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

  Widget _buildRowMenu(context) {
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

  Widget _createListMenu(context, String menuTitle, page, IconData icon) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.to(() => page);
      },
      child: Container(
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
                              : AppTheme.darkColor,
                    ),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
                  ),
                  onPressed: () {},
                  child: SizedBox(
                    width: Get.width / 1.5,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(menuTitle,
                            style: TextStyle(
                                fontSize: 15, color: AppTheme.backgroundColor)),
                        Icon(icon,
                            color: AppTheme.backgroundColor.withOpacity(0.9)),
                      ],
                    ),
                  ))

              // Icon(Icons.chevron_right, size: 20, color: AppTheme.secondaryColor),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBody(context) {
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
            _buildSection1(context),
          ],
        ),
      )
    ];
  }

  Widget _buildSection1(BuildContext context) {
    return SizedBox(
      height: Get.height / 0.90,
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
                        width: Get.width /2.3,
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
                        width: Get.width /2.3,
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
                          defaultCountry: DefaultCountry.France,
                          flagState: CountryFlag.DISABLE,
                          selectedItemStyle: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  color: AppTheme.darkColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500),
                          dropdownDecoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              color: AppTheme.light,
                              border: Border.all(
                                  color: AppTheme.darkColor, width: 0.5)),
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
          borderRadius: const BorderRadius.all(Radius.circular(30)),
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
