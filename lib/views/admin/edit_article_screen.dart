import 'dart:convert';

import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/addArticles/edit_articles_controller.dart';
import 'package:gando/models/Car.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:text_form_field_wrapper/text_form_field_wrapper.dart';

import '../../models/Equipment.dart';
import '../../widget/appBarWidget.dart';
import '../../widget/customTextFormField.dart';

class EditArticleScreen extends StatelessWidget {
  final Car article;

  EditArticleScreen({Key? key, required this.article}) : super(key: key);

  TextEditingController drivingIdController = TextEditingController(
      text: '11 Adile maret, Sainte-Anne 97180');
  TextEditingController kilometerController = TextEditingController();
  TextEditingController dayPrice = TextEditingController(text: '30');
  TextEditingController weekPrice = TextEditingController(text: '160');
  TextEditingController monthPrice = TextEditingController(text: '400');

  final List<String> itemsKilometer = [
    '0-50 000 Km',
    '50-100 000 Km',
    '100 000-150 000 Km',
    '150 000-200 000 Km',
    '+200 000 Km',
  ];

  static List<Equipment> equipmentsList = [
    Equipment(1, 'Climatisation'),
    Equipment(2, 'Régulateur de vitesse'),
    Equipment(3, 'GPS'),
    Equipment(4, 'Siège enfant'),
    Equipment(5, 'bluetooth'),
    Equipment(6, 'Pneus Neige'),
    Equipment(7, 'Caméra de recule'),
  ];

  final _items = equipmentsList
      .map((data) => MultiSelectItem<Equipment>(data, data.name))
      .toList();

  List<Equipment> _selectedEquipments = [];

  final _multiSelectKey = GlobalKey<FormFieldState>();

  final RxString selectedKilometer = ''.obs;
  final RxBool youngDriver = false.obs;
  String? selectedEquipment;

  final c = Get.put(EditArticleController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: AppTheme.backgroundColor.withOpacity(0.9),
        appBar: CustomAppBar(
          leading: IconButton(onPressed: (){
            Get.back();
          }, icon: Icon(Icons.arrow_back_ios_outlined, color: AppTheme.darkColor,),),
          title: 'Modifier mon annonce',
        ),
        body: Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  _buildVehicle(context), //header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          article.brand != null
                              ? 'Photo conforme'
                              : 'Photo non conforme',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                              color: AppTheme.darkColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500)),
                      SizedBox(
                        width: 10,
                      ),
                      Text('En savoir plus',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                              color: AppTheme.primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500)),
                      SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Icons.info_outline_rounded,
                        color: AppTheme.darkColor.withOpacity(0.5),
                        size: 15,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildDescription(context),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        Text('Adresse du vehicule',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                color: AppTheme.darkColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          controller: drivingIdController,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          enabled: true,
                          formatter: [], validator: (String) {  }, hintText: '', onChanged: (String ) {  }, onSaved: (String ) {  },
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        ..._buildPrice(context),
                        _buildKilometer(context),
                        ..._buildEquipment(context),
                        _buildDriverCondition(context),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          height: 90,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 15),
              _buildBottomButton(label: 'Valider'),
              // const SizedBox(height: 36),
            ],
          ),
        ),
      );
    });
  }
  Widget _buildBottomButton({label}) {
    return Container(
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
            // Get.to(() => BookingScreen());
          },
          child: Center(
            child: Text(
              label,
              style: const  TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDescription(context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: TextFormField(
      minLines: 5,
      maxLines: 7,
      controller: c.descriptionController.value,
      style: Theme
          .of(context)
          .textTheme
          .bodyText2!
          .copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        overflow: TextOverflow.visible,
        color: AppTheme.darkColor,
      ),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppTheme.light,
        labelStyle: Theme
            .of(context)
            .textTheme
            .bodyText2!
            .copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          overflow: TextOverflow.visible,
          color: AppTheme.darkColor.withOpacity(0.5),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.darkColor,
              width: 0.5,
            ),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          gapPadding:2
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.darkColor,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            gapPadding:2
        ),
        labelText: 'Description du véhicule',
        border:  OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.darkColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
            gapPadding: 2
        ),
      ),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "Description is Required";
        }
      },
    ),
  );

  Widget _buildDriverCondition(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      child: Column(
        children: [
          Divider(color: AppTheme.darkColor,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Frais jeune conducteur',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w900)),
              const SizedBox(width: 10,),
              Switch(value: youngDriver.value, onChanged: (v){
                youngDriver.value = v;
              })
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text('En cochant cette option, vous autorisezes jeunes conducteurs de 0 à 2 ans\nd\'experience loués votre véhicule. En contreparie, 16% sera ajoutés en plus \nsur le prix final de la location', style: Theme
              .of(context)
              .textTheme
              .bodyText2!
              .copyWith(
              color: AppTheme.darkColor,
              fontSize: 12,
              fontWeight: FontWeight.w400))
        ],
      ),
    );
  }

  Widget _buildKilometer(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text('Kilometrage',
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(
                  color: AppTheme.darkColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500)),
          const SizedBox(
            height: 10,
          ),
          CustomDropdownButton2(
            hint: 'Selectionner Kilometrage',
            dropdownPadding: const EdgeInsets.symmetric(horizontal: 10),
            dropdownDecoration: BoxDecoration(
              color: AppTheme.darkColor,
              borderRadius: BorderRadius.circular(10),
            ),
            dropdownWidth: Get.width / 1.3,
            buttonWidth: Get.width,
            buttonHeight: 50,
            buttonDecoration: BoxDecoration(
                color: AppTheme.darkColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10)
            ),
            dropdownItems: itemsKilometer,
            value: selectedKilometer.value.isNotEmpty ? selectedKilometer.value : null,
            // value: selectedEquipment,
            onChanged: (value) {
              selectedKilometer.value = value!;
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _buildEquipment(context) =>
      [
        Row(
          children: [
            Text('Equipements',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(
                    color: AppTheme.darkColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w900)),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          child: _buildMultiChoiceChip(),
        ),
      ];

  Widget _buildMultiChoiceChip() =>
      MultiSelectDialogField(
        items: _items,
        title: Text("Equipements", style: TextStyle(
          color: AppTheme.darkColor,
          fontSize: 18,
        ),),
        backgroundColor: AppTheme.light,
        selectedColor: AppTheme.darkColor,
        selectedItemsTextStyle: TextStyle(
          color: AppTheme.darkColor,
          fontSize: 16,
        ),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: AppTheme.primaryColor,
            width: 1,
          ),
        ),
        buttonIcon: Icon(
          Icons.settings_bluetooth_rounded,
          color: AppTheme.primaryColor,
        ),
        buttonText: Text(
          "Choisir des équipements",
          style: TextStyle(
            color: AppTheme.darkColor,
            fontSize: 16,
          ),
        ),
        onConfirm: (results) {
          _selectedEquipments.addAll(results);
          // printInfo(info: _selectedEquipments.toString());
        },
      );

  List<Widget> _buildPrice(BuildContext context) =>
      [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 22.0),
              child: Text('Prix jour',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                      padding: EdgeInsets.all(4.5),
                      decoration: BoxDecoration(
                          color: AppTheme.redColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8))),
                      child: Icon(
                        Icons.remove,
                        size: 40,
                      )),
                ),
                SizedBox(
                  width: Get.width / 2,
                  child: TextFormFieldWrapper(
                    borderFocusedColor: AppTheme.primaryColor,
                    borderRadius: 0,
                    formField: TextFormField(
                      controller: dayPrice,
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      style: TextStyle(color: AppTheme.darkColor),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: AppTheme.light,
                          border: InputBorder.none,
                          hintText: 'Prix Jour',
                          hintStyle: TextStyle(
                              color: AppTheme.darkColor.withOpacity(0.5))),
                    ),
                    // position: TextFormFieldPosition.alone,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                      padding: const EdgeInsets.all(4.5),
                      decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8))),
                      child: const Icon(
                        Icons.add,
                        size: 40,
                      )),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 22.0),
              child: Text('Prix semaine',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                      padding: const EdgeInsets.all(4.5),
                      decoration: BoxDecoration(
                          color: AppTheme.redColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8))),
                      child: const Icon(
                        Icons.remove,
                        size: 40,
                      )),
                ),
                SizedBox(
                  width: Get.width / 2,
                  child: TextFormFieldWrapper(
                    borderFocusedColor: AppTheme.primaryColor,
                    borderRadius: 0,
                    formField: TextFormField(
                      controller: weekPrice,
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      style: TextStyle(color: AppTheme.darkColor),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: AppTheme.light,
                          border: InputBorder.none,
                          hintText: 'Prix Jour',
                          hintStyle: TextStyle(
                              color: AppTheme.darkColor.withOpacity(0.5))),
                    ),
                    // position: TextFormFieldPosition.alone,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                      padding: EdgeInsets.all(4.5),
                      decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8))),
                      child: const Icon(
                        Icons.add,
                        size: 40,
                      )),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 22.0),
              child: Text('Prix mois',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                      padding: EdgeInsets.all(4.5),
                      decoration: BoxDecoration(
                          color: AppTheme.redColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8))),
                      child: const Icon(
                        Icons.remove,
                        size: 40,
                      )),
                ),
                SizedBox(
                  width: Get.width / 2,
                  child: TextFormFieldWrapper(
                    borderFocusedColor: AppTheme.primaryColor,
                    borderRadius: 0,
                    formField: TextFormField(
                      controller: monthPrice,
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      style: TextStyle(color: AppTheme.darkColor),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: AppTheme.light,
                          border: InputBorder.none,
                          hintText: 'Prix Jour',
                          hintStyle: TextStyle(
                              color: AppTheme.darkColor.withOpacity(0.5))),
                    ),
                    // position: TextFormFieldPosition.alone,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                      padding: const EdgeInsets.all(4.5),
                      decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: const  BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8))),
                      child: const Icon(
                        Icons.add,
                        size: 40,
                      )),
                ),
              ],
            ),
          ],
        ),
      ];

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
                  image: AssetImage(article.image),
                ),
                borderRadius: BorderRadius.circular(16),
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
                  FloatingActionButton(
                    backgroundColor: AppTheme.light,
                    onPressed: () {},
                    child: Icon(
                      Icons.add,
                      color: AppTheme.primaryColor,
                      size: 40,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
