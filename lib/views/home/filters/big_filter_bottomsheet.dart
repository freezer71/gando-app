import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/search/search_controller.dart';
import 'package:get/get.dart';
import 'package:text_form_field_wrapper/text_form_field_wrapper.dart';

import '../../../widget/customTextFormField.dart';

class Filters extends StatelessWidget {
  Filters({Key? key}) : super(key: key);

  final c = Get.put(SearchController());

  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  TextEditingController minYearController = TextEditingController();
  TextEditingController maxYearController = TextEditingController();

  final List carTypeList = [
    {'title': 'Citadine'},
    {'title': '4x4'},
    {'title': 'Familiale'},
  ];

  final List carTypeList2 = [
    {'title': 'Utilitaire'},
    {'title': 'Coupé'},
    {'title': 'Berline'},
  ];

  final List carTypeList3 = [
    {'title': 'Cabriolet'},
    {'title': 'Minibus'},
    {'title': 'Autre(s)'},
  ];

  final List speedBox = [
    {'title': 'Automatique'},
    {'title': 'Manuelle'},
  ];

  final List fuelList = [
    {'title': 'Essence'},
    {'title': 'Diesel'},
    {'title': 'Hybride'},
    {'title': 'Electrique'},
    {'title': 'Autre(s)'},
  ];

  final List carNumberDoor = [
    2, 3, 4, 5, 6, 7
  ];

  final List carNumberSit = [
    1, 2, 3, 4, 5, 6, 7, 8, 9
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: Get.width,
        height: 900,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: AppTheme.backgroundColor,
        ),
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            header(context),
            Divider(color: AppTheme.secondaryColor.withOpacity(0.3),
              height: 30,
              thickness: 1.3,),
            section1(context),
            Divider(color: AppTheme.secondaryColor.withOpacity(0.3),
              height: 30,
              thickness: 1.3,),
            section2(context),
            Divider(color: AppTheme.secondaryColor.withOpacity(0.3),
              height: 30,
              thickness: 1.3,),
            section3(context),
            Divider(color: AppTheme.secondaryColor.withOpacity(0.3),
              height: 30,
              thickness: 1.3,),
            _buildDoors(),
            Divider(color: AppTheme.secondaryColor.withOpacity(0.3),
              height: 30,
              thickness: 1.3,),
            ageSection(context),
            Divider(color: AppTheme.secondaryColor.withOpacity(0.3),
              height: 30,
              thickness: 1.3,),
            fuelListSection(context),
            Divider(color: AppTheme.secondaryColor.withOpacity(0.3),
              height: 30,
              thickness: 1.3,),
            _buildPlaces(),
            _buildDriverCondition(context),
            const SizedBox(height: 60,),
          ],
        ),
      );
    });
  }

  Widget header(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: Get.width / 2.4,
          ),
          Text(
            'Filtres',
            style: Theme
                .of(context)
                .textTheme
                .bodyText2!
                .copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              overflow: TextOverflow.ellipsis,
              color: AppTheme.darkColor,
            ),
          ),
          const Expanded(child: SizedBox()),
          Container(
            child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.close,
                  color: AppTheme.secondaryColor,
                )),
          ),
        ],
      ),
    );
  }

  Widget section1(BuildContext context) {
    return SizedBox(
      height: Get.height / 5.5,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) =>
                          c.togglePrice.value
                              ? AppTheme.light
                              : AppTheme.primaryColor,
                        ),
                        overlayColor:
                        MaterialStateProperty.all(Colors.transparent),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )),
                      ),
                      onPressed: () {
                        c.togglePrice.value = !c.togglePrice.value;
                      },
                      child: SizedBox(
                        width: Get.width / 1.5,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Prix croissant",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: c.togglePrice.value
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
                          !c.togglePrice.value
                              ? AppTheme.light
                              : AppTheme.primaryColor,
                        ),
                        overlayColor:
                        MaterialStateProperty.all(Colors.transparent),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )),
                      ),
                      onPressed: () {
                        c.togglePrice.value = !c.togglePrice.value;
                      },
                      child: SizedBox(
                        width: Get.width / 1.5,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Prix décroissant",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: !c.togglePrice.value
                                        ? AppTheme.darkColor
                                        : AppTheme.light)),
                          ],
                        ),
                      ))),
            ],
          ),

          SizedBox(height: 20,),
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  verticalDirection: VerticalDirection.down,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: Get.width / 2.2,
                      child: CustomTextFormField(
                        controller: c.priceMin.value,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          return null;
                        },
                        formatter: [],
                        onChanged: (v) {},
                        onSaved: (v) {},
                        hintText: 'Min',
                      ),
                    ),
                    Container(
                      width: Get.width / 2.2,
                      child: CustomTextFormField(
                        controller: c.priceMax.value,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          return null;
                        },
                        formatter: [],
                        onChanged: (v) {},
                        onSaved: (v) {},
                        hintText: 'Max',
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget ageSection(BuildContext context) {
    return SizedBox(
      height: Get.height / 5.5,
      child: Column(
        children: [
          Text(
            'Age du véhicule',
            style: Theme
                .of(context)
                .textTheme
                .bodyText2!
                .copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              overflow: TextOverflow.ellipsis,
              color: AppTheme.darkColor,
            ),
          ),
          SizedBox(height: 20,),
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  verticalDirection: VerticalDirection.down,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: Get.width / 2.2,
                      child: CustomTextFormField(
                        controller: c.minYearController.value,
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          return null;
                        },
                        formatter: [],
                        onChanged: (v) {},
                        onSaved: (v) {},
                        hintText: 'Année min',
                      ),
                    ),
                    Container(
                      width: Get.width / 2.2,
                      child: CustomTextFormField(
                        controller: c.maxYearController.value,
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          return null;
                        },
                        formatter: [],
                        onChanged: (v) {},
                        onSaved: (v) {},
                        hintText: 'Année Max',
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget fuelListSection(BuildContext context) {
    return SizedBox(
      height: Get.height / 5.5,
      child: Column(
        children: [
          Text(
            'Carburant',
            style: Theme
                .of(context)
                .textTheme
                .bodyText2!
                .copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              overflow: TextOverflow.ellipsis,
              color: AppTheme.darkColor,
            ),
          ),
          SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.all(0.0),
            child: GridView.builder(
              key: Get.keys[3],
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: c.fuelList.length,
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
                        MaterialStateProperty.all(c.selectedFuel.value == c.fuelList[index]['title']
                            ? AppTheme.primaryColor
                            : AppTheme.light),
                        overlayColor: MaterialStateProperty.all(Colors
                            .transparent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                      ),
                      onPressed: () {
                        c.selectedFuel.value = c.fuelList[index]['title'];
                      },
                      child: SizedBox(
                        width: Get.width / 1.5,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${c.fuelList[index]['title']}",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: c.fuelList[index]['title'] ==
                                        c.selectedFuel.value
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

  Widget section2(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Type de véhicule',
            style: Theme
                .of(context)
                .textTheme
                .bodyText2!
                .copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              overflow: TextOverflow.ellipsis,
              color: AppTheme.darkColor,
            ),
          ),
          const SizedBox(height: 15,),

          GridView.builder(
            key: Get.keys[2],
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: c.carTypeList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 30,
              crossAxisSpacing: 10,
              mainAxisExtent: 40,
            ),
            itemBuilder: (context, index) {
              return Obx(() {
                return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(c.carTypeList[index]['title'] ==
                          c.selectedType.value
                          ? AppTheme.primaryColor
                          : AppTheme.light),
                      overlayColor: MaterialStateProperty.all(Colors
                          .transparent),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                    ),
                    onPressed: () {
                      c.selectedType.value = c.carTypeList[index]['title'];
                    },
                    child: SizedBox(
                      width: Get.width / 1.5,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${c.carTypeList[index]['title']}",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: c.carTypeList[index] ==
                                      c.selectedType.value
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

  Widget section3(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Boite de vitesse',
            style: Theme
                .of(context)
                .textTheme
                .bodyText2!
                .copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              overflow: TextOverflow.ellipsis,
              color: AppTheme.darkColor,
            ),
          ),
          SizedBox(height: 15,),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) =>
                          c.gearBox.value
                              ? AppTheme.light
                              : AppTheme.primaryColor,
                        ),
                        overlayColor:
                        MaterialStateProperty.all(Colors.transparent),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )),
                      ),
                      onPressed: () {
                        c.gearBox.value = !c.gearBox.value;
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
                                    color: c.gearBox.value
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
                          !c.gearBox.value
                              ? AppTheme.light
                              : AppTheme.primaryColor,
                        ),
                        overlayColor:
                        MaterialStateProperty.all(Colors.transparent),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )),
                      ),
                      onPressed: () {
                        c.gearBox.value = !c.gearBox.value;
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
                                    color: !c.gearBox.value
                                        ? AppTheme.darkColor
                                        : AppTheme.light)),
                          ],
                        ),
                      ))),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCarType(context, num) {
    return SizedBox(
      child: ActionChip(
        elevation: 2,
        labelPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
        backgroundColor: AppTheme.backgroundColor,
        labelStyle: Theme
            .of(context)
            .textTheme
            .bodyText2!
            .copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          overflow: TextOverflow.ellipsis,
          color: AppTheme.backgroundColor,
        ),
        disabledColor: AppTheme.secondaryColor.withOpacity(0.5),
        pressElevation: 8,
        label: Text(num.toString(), style: Theme
            .of(context)
            .textTheme
            .bodyText2!
            .copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          overflow: TextOverflow.ellipsis,
          color: AppTheme.darkColor,
        ),),
        onPressed: () {

        },
      ),
    );
  }

  Widget _buildDoors() {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Nombre de portes',
              style: Theme
                  .of(Get.context!)
                  .textTheme
                  .bodyText2!
                  .copyWith(
                  color: AppTheme.darkColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w900)),
          const SizedBox(
            height: 30,
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
  Widget _buildPlaces() {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Nombre de places',
              style: Theme
                  .of(Get.context!)
                  .textTheme
                  .bodyText2!
                  .copyWith(
                  color: AppTheme.darkColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w900)),
          const SizedBox(
            height: 30,
          ),

          Padding(
            padding: const EdgeInsets.all(0.0),
            child: GridView.builder(
              key: Get.keys[3],
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
                        MaterialStateProperty.all(c.selectedPlaces.value == c.placesList[index]
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

  Widget _buildDriverCondition(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        children: [
          Divider(color: AppTheme.darkColor,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Jeune conducteur',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w900)),
              const SizedBox(width: 10,),
              Switch(value: c.youngDriver.value, onChanged: (v) {
                c.youngDriver.value = v;
              })
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
              'Vous trouverez des véhicules qui peuvent être loués par des conducteurs expérimentés entre 0 à 2 ans.',
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
