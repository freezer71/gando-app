import 'package:csc_picker/csc_picker.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/settings_controller/account_setting_controller.dart';
import 'package:gando/views/home/home.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../../../widget/appBarWidget.dart';
import '../../../widget/customTextFormField.dart';

class MyContactDetailScreen extends StatelessWidget {
  MyContactDetailScreen({Key? key}) : super(key: key);

  final c = Get.put(AccountSettingController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: CustomAppBar(
          leading: IconButton(onPressed: (){
            Get.back();
          }, icon: Icon(Icons.arrow_back_ios_outlined, color: AppTheme.darkColor,),),
          title: 'Mes coordonnées',
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _createListMenu('Civilité', context),
            ..._buildBodyTextField(context),
          ],
        ),
      );
    });
  }

  Widget _createListMenu(String menuTitle, context) {
    return Container(
      width: Get.width / 2,
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: Text(menuTitle, style: Theme
                .of(context)
                .textTheme
                .bodyText2!
                .copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              overflow: TextOverflow.visible,
              color: AppTheme.darkColor.withOpacity(0.7),
            )),
          ),
          Container(width: Get.width / 4,
              child: Divider(indent: 2,
                thickness: 2,
                height: 20,
                color: AppTheme.darkColor.withOpacity(0.2),))
          // Icon(Icons.chevron_right, size: 20, color: AppTheme.secondaryColor),
        ],
      ),
    );
  }

  List<Widget> _buildBodyTextField(BuildContext context) =>
      [
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) =>
                        c.gearboxValue.value
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
                      c.gearboxValue.value = !c.gearboxValue.value;
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
                                  color: c.gearboxValue.value
                                      ? AppTheme.darkColor
                                      : AppTheme.light)),
                        ],
                      ),
                    ))),
            const SizedBox(width: 20,),
            Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) =>
                        !c.gearboxValue.value
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
                      c.gearboxValue.value = !c.gearboxValue.value;
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
                                  color: !c.gearboxValue.value
                                      ? AppTheme.darkColor
                                      : AppTheme.light)),
                        ],
                      ),
                    ))),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          width: Get.width - 40,
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Numéro de téléphone',
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
                controller: c.phoneNumber.value,
                keyboardType: TextInputType.phone,
                autofocus: false,
                validator: (v) { return null;  },
                onChanged: (v) {  },
                onSaved: (v) {  }, hintText: 'Numéro de téléphone', formatter: [],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        //
        Text('date de naissance',
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
        const SizedBox(height: 20),
        Text('Lieu de naissance',
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
          controller: c.phoneNumber.value,
          keyboardType: TextInputType.phone,
          autofocus: false,
          validator: (v) { return null;  },
          onChanged: (v) {  },
          onSaved: (v) {  }, hintText: 'Lieu de naissance', formatter: [],
        ),
        SizedBox(
          height: 10,
        ),
        Text('Adresse',
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
          controller: c.phoneNumber.value,
          keyboardType: TextInputType.streetAddress,
          autofocus: false,
          validator: (v) { return null;  },
          onChanged: (v) {  },
          onSaved: (v) {  }, hintText: 'Adresse', formatter: [],
        ),
        SizedBox(
          height: 10,
        ),
        Text('Complément d\'adresse',
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
          controller: c.phoneNumber.value,
          keyboardType: TextInputType.streetAddress,
          autofocus: false,
          validator: (v) { return null;  },
          onChanged: (v) {  },
          onSaved: (v) {  }, hintText: 'Complément d\'adresse', formatter: [],
        ),
        const SizedBox(
          height: 10,
        ),
        Text('Pays',
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
        CSCPicker(
          showCities: false,
          showStates: false,
          countryDropdownLabel: c.country.value,
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
            c.country(value);
          },
        ),
        Row(
          verticalDirection: VerticalDirection.down,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: Get.width /2.3,
              child: CustomTextFormField(
                controller: c.postalCodeController.value,
                keyboardType: TextInputType.number,
                autofocus: false,
                enabled: true,
                validator: (v) { return null;  },
                onChanged: (v) {  },
                onSaved: (v) {  }, hintText: 'Code Postale', formatter: [],
              ),
            ),
            Container(
              width: Get.width /2.3,
              child: CustomTextFormField(
                controller: c.cityController.value,
                keyboardType: TextInputType.text,
                autofocus: false,
                enabled: true,
                validator: (v) { return null;  },
                onChanged: (v) {  },
                onSaved: (v) {  }, hintText: 'Ville', formatter: [],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),

        _buildSubmitButton(context, () {}, delete: false),
      ];

  Widget _buildSubmitButton(BuildContext context, Callback func, {delete}) {
    return TextButton(
      onPressed: func,
      style: ButtonStyle(
        backgroundColor:
        MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) =>
          states.contains(MaterialState.disabled)
              ? AppTheme.primaryColor
              : delete! ? AppTheme.redColor : AppTheme.primaryColor,
        ),
        overlayColor:
        MaterialStateProperty.all(Colors.transparent),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            )),
      ),
      child: Container(
        height: 40,
        width: Get.width / 1.3,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Center(
          child: Text('Enregistrer', style: Theme
              .of(context)
              .textTheme
              .bodyText2!
              .copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            color: AppTheme.backgroundColor,
          ),),
        ),
      ),
    );
  }
}
