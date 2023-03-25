import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gando/controllers/addArticles/add_articles_controller.dart';
import 'package:get/get.dart';

import '../../../../config/textstyle.dart';

class Step3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Step3State();
  }
}

class Step3State extends State<Step3> {
  static final form3 = GlobalKey<FormState>();
  static TextEditingController controllerEmail = TextEditingController();
  static TextEditingController controllerAddress = TextEditingController();
  static TextEditingController controllerMobileNo = TextEditingController();

  final c = Get.put(AddArticlesController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
          child: Form(
            key: form3,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                ..._buildBody(),
              ],
            ),
          ));
    });
  }

  List<Widget> _buildBody() =>
      [
        TextFormField(
          minLines: 5,
          maxLines: 7,
          controller: c.descriptionController.value,
          style: Theme
              .of(context)
              .textTheme
              .bodyText2!
              .copyWith(
            fontWeight: FontWeight.w200,
            fontSize: 18,
            overflow: TextOverflow.visible,
            color: AppTheme.darkColor,
          ),
          maxLength: 3000,
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
            labelText: 'Description du véhicule',
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
          ),
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Description is Required";
            }
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          minLines: 1,
          controller: c.addressController.value,
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
            labelText: 'Adresse du véhicule',
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
          ),
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Adresse is Required";
            }
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          minLines: 1,
          controller: c.cityController.value,
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
            labelText: 'Ville',
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
          ),
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Ville is Required";
            }
          },
        ),
        const SizedBox(height: 20),
        FutureBuilder(
            future: c.fetchZipCode,
            initialData: null,
            builder: (context, AsyncSnapshot snap) {
              // all state of the future snapshot
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snap.connectionState == ConnectionState.done) {
                // check if the data is null
                if (snap.data == null) {
                  return Center(child: Text('No data'));
                } else {
                  // if the data is not null
                  return Obx(() {
                    return CustomDropdownButton2(
                      key: Get.keys[3],
                      hint: 'Code postal',
                      // dropdownPadding: const EdgeInsets.symmetric(horizontal: 10),
                      dropdownDecoration: BoxDecoration(
                        color: AppTheme.darkColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      dropdownWidth: Get.width - 40,
                      buttonWidth: Get.width,
                      buttonHeight: 60,
                      buttonDecoration: BoxDecoration(
                          color: AppTheme.darkColor.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(30)),
                      dropdownItems: snap.data,
                      value: c.selectedZipCode.value.isNotEmpty
                          ? c.selectedZipCode.value
                          : null,
                      // value: selectedEquipment,
                      onChanged: (value) {
                        c.selectedZipCode.value = value!;
                      },
                    );
                  });
                }
              } else {
                return Center(child: Text('Error'));
              }
            }),

        // TextFormField(
        //   minLines: 1,
        //   maxLength: 5,
        //   controller: c.postalCodeController.value,
        //   style: Theme
        //       .of(context)
        //       .textTheme
        //       .bodyText2!
        //       .copyWith(
        //     fontWeight: FontWeight.w600,
        //     fontSize: 18,
        //     overflow: TextOverflow.visible,
        //     color: AppTheme.darkColor,
        //   ),
        //   keyboardType: TextInputType.number,
        //   decoration: InputDecoration(
        //     filled: true,
        //     fillColor: AppTheme.light,
        //     labelStyle: Theme
        //         .of(context)
        //         .textTheme
        //         .bodyText2!
        //         .copyWith(
        //       fontWeight: FontWeight.w500,
        //       fontSize: 18,
        //       overflow: TextOverflow.visible,
        //       color: AppTheme.darkColor.withOpacity(0.5),
        //     ),
        //     labelText: 'Code postal',
        //     border: const OutlineInputBorder(
        //       borderRadius: BorderRadius.all(Radius.circular(30.0)),
        //     ),
        //   ),
        //   validator: (value) {
        //     if (value!.trim().isEmpty) {
        //       return "Code Postal is Required";
        //     }
        //   },
        // ),
      ];
}
