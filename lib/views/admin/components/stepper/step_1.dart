import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gando/controllers/addArticles/add_articles_controller.dart';
import 'package:gando/models/Equipment.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';

import '../../../../config/textstyle.dart';

class Step1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Step1State();
  }
}

class Step1State extends State<Step1> {
  static final form1 = GlobalKey<FormState>();
  static TextEditingController controllerFirstName = TextEditingController();
  static TextEditingController controllerLastName = TextEditingController();
  static TextEditingController controllerDateOfBirth = TextEditingController();
  static TextEditingController controllerGender = TextEditingController();

  final c = Get.put(AddArticlesController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
          child: Form(
            key: form1,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [..._buildBodyTextField(context)],
            ),
          ));
    });
  }

  List<Widget> _buildBodyTextField(BuildContext context) =>
      [
        TextFormField(
          maxLines: 1,
          controller: c.brandController.value,
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
            labelText: 'Marque',
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Marque is Required";
            }
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          maxLines: 1,
          controller: c.modelController.value,
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
            labelText: 'Modèle',
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Modele is Required";
            }
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          maxLines: 1,
          controller: c.typeController.value,
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
            labelText: 'Type',
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Type is Required";
            }
          },
        ),
        const SizedBox(height: 20),
        _buildKilometer(context),
        const SizedBox(height: 20),
        _buildYearPlate(),
        const SizedBox(height: 20),
        _buildNumberPlate(),
        const SizedBox(height: 20),
        _buildFuel(),
        const SizedBox(height: 20),
        _buildGearBox(),
        const SizedBox(height: 30),
        _buildTechnicalControl(),
        const SizedBox(height: 30),
        _buildTechnicalControlPhoto(),
        const SizedBox(height: 30),
        ..._buildEquipment(context),
        const SizedBox(height: 30),
        _buildPlaces(),
        const SizedBox(height: 30),
        _buildDoors(),
        const SizedBox(height: 30),
      ];

  Widget _buildYearPlate() {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Année d\'immatriculation',
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
          DropdownDatePicker(
            inputDecoration: InputDecoration(
              filled: true,
              fillColor: AppTheme.light,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.darkColor, width: 1.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            // optional
            isDropdownHideUnderline: false,
            // optional
            isFormValidator: true,
            // optional
            startYear: DateTime
                .parse('1969-07-20 20:18:04Z')
                .year,
            // optional
            endYear: DateTime
                .now()
                .year,
            // optional
            width: 0,
            // optional
            // selectedMonth: 12, // optional
            selectedYear: DateTime
                .now()
                .year,
            // optional
            onChangedYear: (value) {
              c.yearController.value = value!;
            },
            boxDecoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.0)),
            // optional
            showDay: false,
            showYear: true,
            showMonth: false,
            // optional
            // dayFlex: 2,
            locale: "en",
            // optional
            hintYear: 'Année',
            // optional
            hintTextStyle: TextStyle(color: AppTheme.darkColor), // optional
          ),
        ],
      ),
    );
  }

  Widget _buildNumberPlate() {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Plaque d\'immatriculation',
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
          TextFormField(
            maxLines: 1,
            controller: c.numberplateController.value,
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
              labelText: 'Plaque d\'immatriculation',
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return "Plaque d\'immatriculation is Required";
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFuel() {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Carburant',
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
          TextFormField(
            maxLines: 1,
            controller: c.fuelController.value,
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
              labelText: 'Carburant',
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return "Carburant is Required";
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGearBox() {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Boite de vitesse',
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
                            Text("Automatique",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: c.gearboxValue.value
                                        ? AppTheme.darkColor
                                        : AppTheme.light)),
                          ],
                        ),
                      ))),
              SizedBox(width: 20,),
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
                            Text("Manuelle",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: !c.gearboxValue.value
                                        ? AppTheme.darkColor
                                        : AppTheme.light)),
                          ],
                        ),
                      ))),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTechnicalControlPhoto() {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Veuillez prendre en photo controle technique',
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
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) =>
                            AppTheme.light
                        ),
                        overlayColor:
                        MaterialStateProperty.all(Colors.transparent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                      ),
                      onPressed: () {

                      },
                      child: SizedBox(
                        width: Get.width / 1.5,
                        height: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.photo_library_outlined,
                              color: AppTheme.primaryColor, size: 40,),
                          ],
                        ),
                      ))),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTechnicalControl() {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Prochain controle technique',
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
          DropdownDatePicker(
            inputDecoration: InputDecoration(
              filled: true,
              fillColor: AppTheme.light,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.darkColor, width: 1.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            // optional
            isDropdownHideUnderline: false,
            // optional
            isFormValidator: true,
            // optional
            startYear: DateTime
                .parse('1969-07-20 20:18:04Z')
                .year,
            // optional
            endYear: DateTime
                .now()
                .year,
            // optional
            width: 0,
            // optional
            selectedDay: DateTime
                .now()
                .day,
            // optional
            // selectedMonth: 12, // optional
            selectedYear: DateTime
                .now()
                .year,
            selectedMonth: DateTime
                .now()
                .month,
            showMonth: true,
            // optional
            onChangedDay: (value) => print('onChangedDay: $value'),
            onChangedMonth: (value) => print('onChangedMonth: $value'),
            onChangedYear: (value) => print('onChangedYear: $value'),
            boxDecoration:
            BoxDecoration(border: Border.all(color: Colors.white, width: 1.0)),
            // optional
            showDay: true,
            // optional
            dayFlex: 1,
            yearFlex: 1,
            locale: "en",
            // optional
            hintDay: 'Jour',
            // optional
            hintMonth: 'Mois',
            // optional
            hintYear: 'Année',
            // optional
            hintTextStyle: TextStyle(color: AppTheme.darkColor), // optional
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
        items: c.items,
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
          results.map((e) => c.selectedEquipments.value = e);
          // c.selectedEquipments.add(results.asMap());
          // printInfo(info: _selectedEquipments.toString());
        },
      );

  Widget _buildPlaces() {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PLaces',
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

          Padding(
            padding: const EdgeInsets.all(0.0),
            child: GridView.builder(
              key: Get.keys[2],
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: c.placesList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: 30,
              ),
              itemBuilder: (context, index) {
                return Obx(() {
                  return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(c.placesList[index] ==
                            c.selectedPlaces.value
                            ? AppTheme.primaryColor
                            : AppTheme.light),
                        overlayColor: MaterialStateProperty.all(Colors
                            .transparent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                      ),
                      onPressed: () {
                        c.selectedPlaces.value = c.placesList[index];
                      },
                      child: SizedBox(
                        width: Get.width / 1.5,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${c.placesList[index]} ${index == c.placesList.length -1 ? '+' : ''}",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: c.placesList[index] ==
                                        c.selectedPlaces.value
                                        ? AppTheme.light
                                        : AppTheme.darkColor)),
                          ],
                        ),
                      ));
                });
              },
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildDoors() {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nombre de portes',
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

          Padding(
            padding: const EdgeInsets.all(0.0),
            child: GridView.builder(
              key: Get.keys[3],
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: c.doorList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: 30,
              ),
              itemBuilder: (context, index) {
                return Obx(() {
                  return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(c.selectedDoor.value == c.doorList[index]
                            ? AppTheme.primaryColor
                            : AppTheme.light),
                        overlayColor: MaterialStateProperty.all(Colors
                            .transparent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                      ),
                      onPressed: () {
                        c.selectedDoor.value = c.doorList[index];
                      },
                      child: SizedBox(
                        width: Get.width / 1.5,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${c.doorList[index]} ${index == c.doorList.length -1 ? '+' : ''}",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: c.doorList[index] ==
                                        c.selectedDoor.value
                                        ? AppTheme.light
                                        : AppTheme.darkColor)),
                          ],
                        ),
                      ));
                });
              },
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildKilometer(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                borderRadius: BorderRadius.circular(10)),
            dropdownItems: c.itemsKilometer,
            value: c.selectedKilometer.value.isNotEmpty
                ? c.selectedKilometer.value
                : null,
            // value: selectedEquipment,
            onChanged: (value) {
              c.selectedKilometer.value = value!;
            },
          ),
        ],
      ),
    );
  }
}
