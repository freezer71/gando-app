import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/constants.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/addArticles/edit_articles_controller.dart';
import 'package:gando/models/Car.dart';
import 'package:gando/widget/reusable/cache_image_network.dart';
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
import '../../models/UserCar.dart';
import '../../widget/appBarWidget.dart';
import '../../widget/customTextFormField.dart';

class EditArticleScreen extends GetView<EditArticleController> {
  final Car car;

  EditArticleScreen({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<EditArticleController>(
      assignId: true,
      init: EditArticleController(id: car.id),
      builder: (logic) {
        return Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          appBar: CustomAppBar(
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: AppTheme.darkColor,
              ),
            ),
            title: 'Modifier mon annonce',
          ),
          body: FutureBuilder(
              future: controller.futureGetCar,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Scaffold(
                      body: Center(
                        child: Text('Error'),
                      ),
                    );
                  } else {
                    final Car car = snapshot.data;
                    return Container(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              _buildVehicle(context, car), //header
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      true
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
                                  const SizedBox(
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
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Icon(
                                    Icons.info_outline_rounded,
                                    color: AppTheme.darkColor.withOpacity(
                                        0.5),
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
                                      controller: controller.addressController
                                          .value,
                                      keyboardType: TextInputType.text,
                                      autofocus: false,
                                      enabled: true,
                                      formatter: [],
                                      validator: (String) {},
                                      hintText: '',
                                      onChanged: (String) {},
                                      onSaved: (String) {},
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
                    );
                  }
                } else {
                  return const Scaffold(
                    body: Center(
                      child: Text('Error'),
                    ),
                  );
                }

              }
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
      },
    );
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
  }

  Widget _buildDescription(context) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          minLines: 5,
          maxLines: 7,
          controller: controller.descriptionController.value,
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
                gapPadding: 2),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.darkColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                gapPadding: 2),
            labelText: 'Description du véhicule',
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.darkColor,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                gapPadding: 2),
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
              Obx(() => Switch(
                value: controller.youngDriver.value,
                onChanged: (value) {
                  controller.youngDriver.value = value;
                },
                activeColor: AppTheme.primaryColor,
                activeTrackColor: AppTheme.primaryColor.withOpacity(0.5),
                inactiveThumbColor: AppTheme.redColor,
                inactiveTrackColor: AppTheme.redColor.withOpacity(0.5),
              ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
              'En cochant cette option, vous authorisés les jeunes conducteurs de 0 à 3 ans d\'experience loués\nvotre véhicule. En contreparie, 20% sera ajoutés en plus sur le prix final de la location',
              style: Theme
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
                borderRadius: BorderRadius.circular(10)),
            dropdownItems: controller.itemsKilometer,
            value: controller.selectedKilometer.value.isNotEmpty
                ? controller.selectedKilometer.value
                : null,
            // value: selectedEquipment,
            onChanged: (value) {
              controller.selectedKilometer.value = value!;
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
        items: controller.items,
        title: Text(
          "Equipements",
          style: TextStyle(
            color: AppTheme.darkColor,
            fontSize: 18,
          ),
        ),
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
          controller.selectedEquipments.addAll(results);
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
                  onTap: () {
                    final num = int.parse(controller.dayPrice.value.text);
                    if(num >= 10) {
                      final val = num == null || num < 1 ? 10 : num - 10;
                      controller.dayPrice.value.text = '$val';

                    }else {
                      controller.dayPrice.value.text = '0';
                    }
                  },
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
                    ),
                  ),
                ).marginZero,
                SizedBox(
                  width: Get.width / 2,
                  child: TextFormFieldWrapper(
                    borderFocusedColor: AppTheme.primaryColor,
                    borderRadius: 0,
                    formField: TextFormField(
                      key: Get.keys[0],
                      controller: controller.dayPrice.value,
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
                  onTap: () {
                    final num = int.parse(controller.dayPrice.value.text);
                    if(num > 0 || num == 0) {
                      final val =  num + 10;
                      controller.dayPrice.value.text = '$val';
                    }else {
                      controller.dayPrice.value.text = '0';
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4.5),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),),),
                    child: const Icon(
                      Icons.add,
                      size: 40,
                    ),
                  ),
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
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    final num = int.parse(controller.weekPrice.value.text);
                    if(num >= 10){
                      final val = num == null || num < 1 ? 10 : num - 10;
                      controller.weekPrice.value.text = '$val';

                    }else {
                      controller.weekPrice.value.text = '0';
                    }
                  },
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
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width / 2,
                  child: TextFormFieldWrapper(
                    borderFocusedColor: AppTheme.primaryColor,
                    borderRadius: 0,
                    formField: TextFormField(
                      key: Get.keys[1],
                      controller: controller.weekPrice.value,
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer le prix de la semaine';
                        }
                        return null;
                      },
                      style: TextStyle(color: AppTheme.darkColor),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppTheme.light,
                        border: InputBorder.none,
                        hintText: 'Prix semaine',
                        hintStyle: TextStyle(
                          color: AppTheme.darkColor.withOpacity(0.5),
                        ),
                      ),
                    ),
                    // position: TextFormFieldPosition.alone,
                  ),
                ),
                InkWell(
                  onTap: () {
                    final num = int.parse(controller.weekPrice.value.text);
                    if(num > 0 || num == 0){
                      final val =  num + 10;
                      controller.weekPrice.value.text = '$val';
                    }else {
                      controller.weekPrice.value.text = '10';
                    }
                  },
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
                    ),
                  ),
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
                  onTap: () {
                    final num = int.parse(controller.monthPrice.value.text);
                    if(num >= 10){
                      final val = num == null || num < 1 ? 10 : num - 10;
                      controller.monthPrice.value.text = '$val';

                    }else {
                      controller.monthPrice.value.text = '0';
                    }
                  },
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
                      key: Get.keys[2],
                      controller: controller.monthPrice.value,
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      style: TextStyle(color: AppTheme.darkColor),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: AppTheme.light,
                          border: InputBorder.none,
                          hintText: 'Prix mois',
                          hintStyle: TextStyle(
                              color: AppTheme.darkColor.withOpacity(0.5))),
                    ),
                    // position: TextFormFieldPosition.alone,
                  ),
                ),
                InkWell(
                  onTap: () {
                    final num = int.parse(controller.monthPrice.value.text);
                    if(num > 0 || num == 0){
                      final val =  num + 10;
                      controller.monthPrice.value.text = '$val';
                    }else {
                      controller.monthPrice.value.text = '10';
                    }
                  },
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
      ];

  Widget _buildVehicle(context, Car article) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppTheme.primaryColor),
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: SizedBox(
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: Get.height / 5,
              width: Get.width / 1.58,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  repeat: ImageRepeat.noRepeat,
                  alignment: Alignment.topCenter,
                  image: CachedNetworkImageProvider(
                      (article.images!.ariere34!.isNotEmpty ? article.images!.ariere34! :  '')  ),
                ),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16)),
              ),
              // child: buildCacheNetworkImage(
              //   url: APP_FILE+'1675603931368.jpg',
              //   height: Get.height / 5,
              //   width: Get.width,
              // ),
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
