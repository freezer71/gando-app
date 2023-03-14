import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:text_form_field_wrapper/text_form_field_wrapper.dart';

import '../../../../config/textstyle.dart';
import '../../../../controllers/addArticles/add_articles_controller.dart';

class Upload extends StatefulWidget {

  var mapInfo = HashMap<String, dynamic>();

  Upload(this.mapInfo);

  @override
  State<StatefulWidget> createState() {
    return UploadState();
  }
}

class UploadState extends State<Upload> {
  static final finalForm = GlobalKey<FormState>();

  final c = Get.put(AddArticlesController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Form(
        key: finalForm,
        child: Column(
          children: [
            ..._buildPrice(context),
            const SizedBox(height: 20,),
            _buildDriverCondition(context),
            const SizedBox(height: 20,),
          ],
        ),
      );
    });
  }

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
                    final num = int.parse(c.dayPriceController.value.text);
                    if(num >= 10) {
                      final val = num == null || num < 1 ? 10 : num - 10;
                      c.dayPriceController.value.text = '$val';
                     
                    }else {
                      c.dayPriceController.value.text = '0';
                     
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
                      controller: c.dayPriceController.value,
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
                    final num = int.parse(c.dayPriceController.value.text);
                    if(num > 0 || num == 0) {
                      final val =  num + 10;
                      c.dayPriceController.value.text = '$val';
                     
                    }else {
                      c.dayPriceController.value.text = '0';
                     
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
                    final num = int.parse(c.weekPriceController.value.text);
                    if(num >= 10){
                      final val = num == null || num < 1 ? 10 : num - 10;
                      c.weekPriceController.value.text = '$val';
                     
                    }else {
                      c.weekPriceController.value.text = '0';
                     
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
                      controller: c.weekPriceController.value,
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
                    final num = int.parse(c.weekPriceController.value.text);
                    if(num > 0 || num == 0){
                      final val =  num + 10;
                      c.weekPriceController.value.text = '$val';
                    }else {
                      c.weekPriceController.value.text = '10';
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
                    final num = int.parse(c.monthPriceController.value.text);
                    if(num >= 10){
                      final val = num == null || num < 1 ? 10 : num - 10;
                      c.monthPriceController.value.text = '$val';
                     
                    }else {
                      c.monthPriceController.value.text = '0';
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
                      controller: c.monthPriceController.value,
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
                    final num = int.parse(c.monthPriceController.value.text);
                    if(num > 0 || num == 0){
                      final val =  num + 10;
                      c.monthPriceController.value.text = '$val';
                    }else {
                      c.monthPriceController.value.text = '10';
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

  Widget _buildDriverCondition(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                value: c.youngDriver.value,
                onChanged: (value) {
                  c.youngDriver.value = value;
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
}
