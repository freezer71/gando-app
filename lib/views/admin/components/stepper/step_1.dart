import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gando/controllers/addArticles/add_articles_controller.dart';
import 'package:gando/controllers/car/car_brand_controller.dart';
import 'package:gando/models/CarBrandModel.dart';
import 'package:gando/models/Equipment.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';

import '../../../../config/textstyle.dart';
import '../../../../widget/customTextFormField.dart';

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
  final brandController = Get.put(CarBrandController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // c.onClose();
    super.dispose();
  }

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

  List<Widget> _buildBodyTextField(BuildContext context) {

    return [
      GetBuilder<CarBrandController>(
        assignId: true,
        init: CarBrandController(),
        builder: (controller) {
          return FutureBuilder(
              future: controller.futureGetCarBrands,
              initialData: null,
              builder: (BuildContext context, snapshot) {
                // state
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  printInfo(info: "SNAP DATA ===> ${snapshot.data}");

                  if (snapshot.data != null) {
                    return Obx(() {
                      return Column(
                        children: [
                          CustomDropdownButton2(
                            key: Get.keys[0],
                            hint: 'Marque',
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
                            dropdownItems: controller.getBrandNames(snapshot.data),
                            value: controller.selectedBrand.value,
                            // value: selectedEquipment,
                            onChanged: (value) {
                              controller.selectedBrand(value);
                              // update state
                              print('selected BRAND = $value');
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomDropdownButton2(
                            key: Get.keys[1],
                            hint: 'Model',
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
                            dropdownItems: controller.getModelNames(snapshot.data),
                            value: controller.selectedModel.value,
                            // value: selectedEquipment,
                            onChanged: (value) {
                              controller.selectedModel(value);
                              print('selected MODEL = $value');
                            },
                          ),
                        ],
                      );
                    });
                  } else {
                    return Container();
                  }
                }
              });
        },
      ),
      // CustomTextFormField(
      //     key: Get.keys[0],
      //     controller: c.brandController.value,
      //     keyboardType: TextInputType.text,
      //     validator: (value) {
      //       if (!value!.isNotEmpty) {
      //         return "Marque invalid";
      //         // return 'amount Is not valid';
      //       }
      //       return null;
      //     },
      //     formatter: [
      //       LengthLimitingTextInputFormatter(60),
      //       FilteringTextInputFormatter.singleLineFormatter
      //     ],
      //     onChanged: (p) {
      //       print('saved $p');
      //     },
      //     onSaved: (p) {
      //       print('saved $p');
      //     },
      //     hintText: 'Marque'),
      // const SizedBox(height: 20),
      // CustomTextFormField(
      //     key: Get.keys[1],
      //     controller: c.modelController.value,
      //     keyboardType: TextInputType.text,
      //     validator: (value) {
      //       if (!value!.isNotEmpty) {
      //         return "Modèle invalid";
      //         // return 'amount Is not valid';
      //       }
      //       return null;
      //     },
      //     formatter: [
      //       LengthLimitingTextInputFormatter(60),
      //       FilteringTextInputFormatter.singleLineFormatter
      //     ],
      //     onChanged: (p) {
      //       print('saved $p');
      //     },
      //     onSaved: (p) {
      //       print('saved $p');
      //     },
      //     hintText: 'Modèle'),
      const SizedBox(height: 20),
      CustomTextFormField(
          key: Get.keys[2],
          controller: c.typeController.value,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (!value!.isNotEmpty) {
              return "Type invalid";
              // return 'amount Is not valid';
            }
            return null;
          },
          formatter: [
            LengthLimitingTextInputFormatter(60),
            FilteringTextInputFormatter.singleLineFormatter
          ],
          onChanged: (p) {
            print('saved $p');
          },
          onSaved: (p) {
            print('saved $p');
          },
          hintText: 'Type'),
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
  }

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
            key: Get.keys[4],
            inputDecoration: InputDecoration(
              filled: true,
              fillColor: AppTheme.light,
              enabled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.darkColor, width: 0.5),
                borderRadius: BorderRadius.circular(30),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.darkColor, width: 0.5),
                borderRadius: BorderRadius.circular(30),
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
                border: Border.all(color: Colors.transparent, width: 0.0)),
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
          CustomTextFormField(
              key: Get.keys[5],
              controller: c.numberplateController.value,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (!value!.isNotEmpty) {
                  return "Plaque d\'immatriculation invalid";
                  // return amount Is not valid';
                }
                return null;
              },
              formatter: [
                LengthLimitingTextInputFormatter(60),
                FilteringTextInputFormatter.singleLineFormatter
              ],
              onChanged: (p) {
                print('saved $p');
              },
              onSaved: (p) {
                print('saved $p');
              },
              hintText: 'Plaque d\'immatriculation'),
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
          CustomDropdownButton2(
            key: Get.keys[6],
            hint: 'Carburant',
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
            dropdownItems: c.itemsFuel,
            value: c.selectedFuel.value.isNotEmpty
                ? c.selectedFuel.value
                : null,
            // value: selectedEquipment,
            onChanged: (value) {
              c.selectedFuel.value = value!;
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
          Container(
            child: Row(
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
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
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
                      )),
                ),
              ],
            ),
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
                child: c.selectedFile.value == null ? ElevatedButton(
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
                    // get image from galerie or camera
                    _getImage();
                  },
                  child: SizedBox(
                    width: Get.width / 1.5,
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.photo_camera_outlined,
                              color: AppTheme.primaryColor, size: 40,),
                            Text("Prendre une photo",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: AppTheme.primaryColor)),
                          ],
                        ),
                      ],
                    ),
                  ),) : Stack(
                  fit: StackFit.loose,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.8),
                              Colors.transparent
                            ],
                          ).createShader(Rect.fromLTRB(
                              0, 350, rect.width, 100));
                        },
                        blendMode: BlendMode.darken,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            c.selectedFile.value!,
                            width: Get.width,
                            height: 160,
                            fit: BoxFit.cover,
                            repeat: ImageRepeat.noRepeat,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -10,
                      right: -10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.redColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.delete_outline,
                            color: AppTheme.light,),
                          onPressed: () {
                            c.selectedFile.value = null;
                          },
                        ),
                      ),
                    ),

                  ],
                ),),
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
          // CustomDropdownDatePicker
          DropdownDatePicker(
            key: Get.keys[7],
            inputDecoration: InputDecoration(
              filled: true,
              contentPadding: EdgeInsets.zero,
              fillColor: AppTheme.light,
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.darkColor, width: .5),
                borderRadius: BorderRadius.circular(30),
                gapPadding: 0,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.darkColor, width: .5),
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
            DateTime
                .now()
                .year,
            // optional
            endYear: DateTime
                .now()
                .year + 10,
            // optional
            width: 1,
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
            onChangedDay: (value) {
              c.selectedDayTech.value = value!;
            },
            onChangedMonth: (value) {
              c.selectedMonthTech.value = value!;
            },
            onChangedYear: (value) {
              c.selectedYearTech.value = value!;
            },
            boxDecoration: BoxDecoration(
                border: Border.all(color: Colors.transparent, width: 0.0)),
            // optional
            showDay: true,
            // optional
            dayFlex: 2,
            locale: "en",
            // optional
            hintDay: 'Jour',
            // optional
            hintMonth: 'Mois',
            // optional
            hintYear: 'Année',
            // optional
            hintTextStyle: TextStyle(
                color: AppTheme.redColor, fontSize: 9), // optional
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
          c.selectedEquipments.clear();
          results.map((e) => c.selectedEquipments.add(e.name)).toList();
          // c.selectedEquipments.add(results.asMap());
          // printInfo(info: _selectedEquipments.toString());
        },
      );

  Widget _buildPlaces() {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: Text('PLaces',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(
                    color: AppTheme.darkColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
          ),
          GridView.builder(
            key: Get.keys[2],
            shrinkWrap: true,
            padding: EdgeInsets.zero,
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
                          Text("${c.placesList[index]} ${index ==
                              c.placesList.length - 1 ? '+' : ''}",
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
              padding: EdgeInsets.zero,
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
                        MaterialStateProperty.all(c.selectedDoor.value ==
                            c.doorList[index]
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
                            Text("${c.doorList[index]} ${index ==
                                c.doorList.length - 1 ? '+' : ''}",
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
            key: Get.keys[3],
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
                borderRadius: BorderRadius.circular(30)),
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

  void _getImage() {
    c.choosedImage.value = 5;
    // show bottom sheet on row button included icons to select camera or gallery maxheight is 100
    Get.bottomSheet(
      Container(
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(AppTheme.primaryColor),
                  overlayColor: MaterialStateProperty.all(
                      AppTheme.primaryColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  )),
                ),
                onPressed: () {
                  Get.back();
                  c.pickImage('camera');
                },
                child: Row(
                  children: [
                    Icon(
                        Icons.camera_alt_outlined, color: AppTheme.darkColor),
                    const SizedBox(width: 10,),
                    Text(
                      'Camera', style: TextStyle(color: AppTheme.darkColor),),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(AppTheme.primaryColor),
                  overlayColor: MaterialStateProperty.all(
                      AppTheme.primaryColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  )),
                ),
                onPressed: () {
                  Get.back();
                  c.pickImage('gallery');
                },
                child: Row(
                  children: [
                    Icon(Icons.photo_library_outlined,
                        color: AppTheme.darkColor),
                    const SizedBox(width: 10,),
                    const Text(
                      'Gallery', style: TextStyle(color: Colors.black),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // Get.bottomSheet(
    //   Container(
    //
    //     height: Get.height / 2,
    //     decoration: const BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.only(
    //         topLeft: Radius.circular(20),
    //         topRight: Radius.circular(20),
    //       ),
    //     ),
    //     child: Column(
    //       children: [
    //         ListTile(
    //           leading: const Icon(Icons.camera_alt),
    //           title: const Text('Camera'),
    //           onTap: () async {
    //             c.pickImage('camera');
    //           },
    //         ),
    //         ListTile(
    //           leading: const Icon(Icons.image),
    //           title: const Text('Gallery'),
    //           onTap: () async{
    //             c.pickImage('gallery');
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );


  }
}

class CustomDropdownDatePicker {
  const CustomDropdownDatePicker({
    required this.hint,
    required this.dropdownWidth,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.dropdownDecoration,
    required this.buttonDecoration,
    required this.dropdownItems,
    required this.value,
    required this.onChanged,
  });

  final String hint;
  final double dropdownWidth;
  final double buttonWidth;
  final double buttonHeight;
  final BoxDecoration dropdownDecoration;
  final BoxDecoration buttonDecoration;
  final List<DropdownMenuItem<String>> dropdownItems;
  final String? value;
  final void Function(String?)? onChanged;


  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth,
      height: buttonHeight,
      decoration: buttonDecoration,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(
            hint,
            style: Theme
                .of(context)
                .textTheme
                .bodyText2!
                .copyWith(
              color: AppTheme.darkColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          dropdownColor: AppTheme.darkColor,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: AppTheme.darkColor,
          ),
          isExpanded: true,
          value: value,
          items: dropdownItems,
          onChanged: onChanged,
          style: Theme
              .of(context)
              .textTheme
              .bodyText2!
              .copyWith(
            color: AppTheme.darkColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

}
