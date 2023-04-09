import 'package:country_code_picker/country_code_picker.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/user/user_controller.dart';
import 'package:gando/widget/submit_with_loading_button.dart';
import 'package:get/get.dart';

import '../../../../widget/appBarWidget.dart';
import '../../../../widget/customTextFormField.dart';

class MyContactDetailScreen extends GetView<UserController> {
  MyContactDetailScreen({Key? key}) : super(key: key);

  static final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: CustomAppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
              Get.back();
              Get.back();
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: AppTheme.darkColor,
            ),
          ),
          title: 'Mes coordonnées',
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text("Complétez mes coordonnées",
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: AppTheme.darkColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Civilité',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: AppTheme.darkColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            ..._buildBodyTextField(context),
          ],
        ),
      );
    });
  }

  List<Widget> _buildBodyTextField(BuildContext context) => [
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) =>
                            controller.gearboxValue.value
                                ? AppTheme.light
                                : AppTheme.primaryColor,
                      ),
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                    ),
                    onPressed: () {
                      controller.gearboxValue.value =
                          !controller.gearboxValue.value;
                    },
                    child: SizedBox(
                      width: Get.width / 1.5,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Monsieur",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: controller.gearboxValue.value
                                      ? AppTheme.darkColor
                                      : AppTheme.light)),
                        ],
                      ),
                    ))),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) =>
                            !controller.gearboxValue.value
                                ? AppTheme.light
                                : AppTheme.primaryColor,
                      ),
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                    ),
                    onPressed: () {
                      controller.gearboxValue.value =
                          !controller.gearboxValue.value;
                    },
                    child: SizedBox(
                      width: Get.width / 1.5,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Madame",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: !controller.gearboxValue.value
                                      ? AppTheme.darkColor
                                      : AppTheme.light)),
                        ],
                      ),
                    ))),
          ],
        ),
        const SizedBox(height: 20),
        Text('Date de naissance',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: AppTheme.darkColor,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        const SizedBox(
          height: 10,
        ),
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
          startYear: DateTime.parse('1969-07-20 20:18:04Z').year,
          // optional
          endYear: DateTime.now().year,
          // optional
          width: 2,
          // optional
          selectedDay:
              controller.user.value.dayOfBirth?.day ?? DateTime.now().day,
          // optional
          // selectedMonth: 12, // optional
          selectedYear:
              controller.user.value.dayOfBirth?.year ?? DateTime.now().year,
          selectedMonth:
              controller.user.value.dayOfBirth?.month ?? DateTime.now().month,
          showMonth: true,
          monthFlex: 2,
          // optional
          onChangedDay: (value) => controller.onChangedBirthDate(
              birthDayChanged: value!,
              birthYearChanged: controller.birthYear,
              birthMonthChanged: controller.birthMonth),
          onChangedMonth: (value) => controller.onChangedBirthDate(
              birthMonthChanged: value!,
              birthDayChanged: controller.birthDay,
              birthYearChanged: controller.birthYear),
          onChangedYear: (value) => controller.onChangedBirthDate(
              birthYearChanged: value!,
              birthDayChanged: controller.birthDay,
              birthMonthChanged: controller.birthMonth),
          boxDecoration: BoxDecoration(
              border: Border.all(
                  color: Colors.transparent, width: 0.0)), // optional
          showDay: true, // optional
          dayFlex: 2,
          locale: "en", // optional
          hintDay: 'Jour', // optional
          hintMonth: 'Mois', // optional
          hintYear: 'Année', // optional
          hintTextStyle:
              TextStyle(color: AppTheme.redColor, fontSize: 9), // optional
        ),
        const SizedBox(height: 20),
        Text('Lieu de naissance',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: AppTheme.darkColor,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        const SizedBox(
          height: 10,
        ),
        CustomTextFormField(
          controller: controller.birthPlaceController.value,
          keyboardType: TextInputType.text,
          autofocus: false,
          validator: (v) {
            if (v!.trim().isEmpty) {
              return "Lieu de naissance obligatoire";
            }
          },
          onChanged: (v) {},
          onSaved: (v) {},
          hintText: ' ',
          formatter: [],
        ),
        const SizedBox(
          height: 10,
        ),
        Text('Adresse',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: AppTheme.darkColor,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        const SizedBox(
          height: 10,
        ),
        CustomTextFormField(
          controller: controller.addressController.value,
          keyboardType: TextInputType.streetAddress,
          autofocus: false,
          validator: (v) {
            if (v!.trim().isEmpty) {
              return "Addresse obligatoire";
            }
          },
          onChanged: (v) {},
          onSaved: (v) {},
          hintText: ' ',
          formatter: [],
        ),
        const SizedBox(
          height: 10,
        ),
        Text('Complément d\'adresse',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: AppTheme.darkColor,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        const SizedBox(
          height: 10,
        ),
        CustomTextFormField(
          controller: controller.complementController.value,
          keyboardType: TextInputType.streetAddress,
          autofocus: false,
          validator: (v) {
            if (v!.trim().isEmpty) {
              return "Complement d'addresse obligatoire";
            }
          },
          onChanged: (v) {},
          onSaved: (v) {},
          hintText: ' ',
          formatter: [],
        ),
        const SizedBox(
          height: 10,
        ),
        Text('Pays',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: AppTheme.darkColor,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 60,
          decoration: BoxDecoration(
              color: AppTheme.light,
              borderRadius: const BorderRadius.all(Radius.circular(60)),
              border: Border.all(width: 1.0)),
          child: CountryCodePicker(
            onChanged: controller
                .onCountryCodePicked, // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
            initialSelection: controller.initialSelectionCountry.value,
            favorite: const ['+33', 'FR'],
            showFlag: false,
            showOnlyCountryWhenClosed: true,
            showCountryOnly: true,
            alignLeft: true,
            padding: const EdgeInsets.only(left: 15.0),
            textStyle: TextStyle(color: AppTheme.darkColor, fontSize: 16),
            dialogTextStyle: TextStyle(color: AppTheme.darkColor),
            searchStyle: TextStyle(color: AppTheme.darkColor),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          verticalDirection: VerticalDirection.down,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Code postal',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppTheme.darkColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 10),
                SizedBox(
                  width: Get.width / 2.3,
                  child: CustomTextFormField(
                    controller: controller.postalCodeController.value,
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    enabled: true,
                    validator: (v) {
                      if (v!.trim().isEmpty) {
                        return "Code postal obligatoire";
                      }
                    },
                    onChanged: (v) {},
                    onSaved: (v) {},
                    hintText: ' ',
                    formatter: [],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ville',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppTheme.darkColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 10),
                SizedBox(
                  width: Get.width / 2.3,
                  child: CustomTextFormField(
                    controller: controller.cityController.value,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    enabled: true,
                    validator: (v) {
                      if (v!.trim().isEmpty) {
                        return "Ville obligatoire";
                      }
                    },
                    onChanged: (v) {},
                    onSaved: (v) {},
                    hintText: ' ',
                    formatter: [],
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        SubmitWithLoadingButton(
          text: 'Confirmer'.toUpperCase(),
          onPressed: () async {
            Get.focusScope!.unfocus();
            await controller.editCoordonates();
            if (controller.isSuccess.value) {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            }
          },
          isLoading: controller.isLoading.value,
        ),
      ];
}
