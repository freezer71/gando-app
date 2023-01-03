import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/contract_controller/contract_controller.dart';
import 'package:gando/generated/assets.dart';
import 'package:gando/widget/customTextFormField.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import 'contract_step_3.dart';

class ContractStep2 extends StatelessWidget {
  ContractStep2({Key? key}) : super(key: key);

  final c = Get.put(ContractController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.backgroundColor,
        automaticallyImplyLeading: false,
        title: _buildBodyButtons(),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: [
            const SizedBox(height: 20,),
            Center(
              child: Container(
                width: 150,
                height: 150,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryColor,
                      AppTheme.redColor,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: const [0.5, 0.0],
                  ),
                ),
                child: Image.asset(
                  Assets.imagesImg,
                  scale: 2.8,
                ),
              ),
            ),
            SizedBox(
              width: Get.width,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Il est obligatoire de passer par une vérification de votre permis pour accéder totalement à la location',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppTheme.darkColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 90,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Recto".toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          color: AppTheme.darkColor
                                              .withOpacity(0.5),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                              Icon(
                                Icons.camera_alt_outlined,
                                size: 30,
                                color: AppTheme.darkColor.withOpacity(0.5),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Image.asset(
                            Assets.imagesImg,
                            scale: 2,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 90,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Verso".toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          color: AppTheme.darkColor
                                              .withOpacity(0.5),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                              Icon(
                                Icons.camera_alt_outlined,
                                size: 30,
                                color: AppTheme.darkColor.withOpacity(0.5),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Image.asset(
                            Assets.imagesImg,
                            scale: 2,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: Get.width,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Le conducteur doit être agée de minimum 18 ans.',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
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
                          controller: c.idController.value,
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  CustomTextFormField(
                    controller: c.idController.value,
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    validator: (v) { return null;  },
                    onChanged: (v) {  },
                    onSaved: (v) {  }, hintText: 'Pays d\'obtention', formatter: [],
                  ),

                  // CustomDropdownButton2(
                  //   hint: '01',
                  //   // dropdownPadding: const EdgeInsets.symmetric(horizontal: 10),
                  //   dropdownDecoration: BoxDecoration(
                  //     color: AppTheme.darkColor,
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   dropdownWidth: Get.width - 40,
                  //   buttonWidth: Get.width,
                  //   buttonHeight: 60,
                  //   buttonDecoration: BoxDecoration(
                  //       color: AppTheme.darkColor.withOpacity(0.8),
                  //       borderRadius: BorderRadius.circular(10)),
                  //   dropdownItems: c.itemsKilometer,
                  //   value: c.selectedKilometer.value.isNotEmpty
                  //       ? c.selectedKilometer.value
                  //       : null,
                  //   // value: selectedEquipment,
                  //   onChanged: (value) {
                  //     c.selectedKilometer.value = value!;
                  //   },
                  // ),
                  const SizedBox(height: 40,),
                  _buildSubmitButton(context, () {
                    // Get.to()
                  }, delete: false),

                  const SizedBox(height: 80,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }



  Widget _buildSubmitButton(BuildContext context, Callback? func, {bool? delete} ){
    return TextButton(
      onPressed: func,
      style: ButtonStyle(
        backgroundColor:
        MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) =>
              delete! ? AppTheme.redColor : AppTheme.primaryColor,
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
          child: Text('Valider'.toUpperCase(), style: Theme.of(context).textTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            color: AppTheme.backgroundColor,
          ),),
        ),
      ),
    );
  }

  Widget _buildBodyButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(29)),
          // splashColor: const Color(0xFFEEEEEE),
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Icon(
              Icons.arrow_back_rounded,
              color: AppTheme.darkColor,
            ),
          ),
        ),
        Container(
          height: 48,
          margin: EdgeInsets.symmetric(vertical: 10),
          width: Get.width / 2.2,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(29)),
            color: AppTheme.primaryColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
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
                Get.off(() => ContractStep3());
              },
              child: Center(
                child: Text(
                  'Suivant'.toUpperCase(),
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
