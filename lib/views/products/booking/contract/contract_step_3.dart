import 'package:expandable_text/text_parser.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/contract_controller/contract_controller.dart';
import 'package:gando/generated/assets.dart';
import 'package:gando/widget/customTextFormField.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'contract_step_4.dart';

class ContractStep3 extends StatelessWidget {
  ContractStep3({Key? key}) : super(key: key);

  final c = Get.put(ContractController());

  final double carState = 40.0;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
          margin: const EdgeInsets.only(top: 20),
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
                    Assets.imagesImg1,
                    scale: 2.8,
                  ),
                ),
              ),
              SizedBox(
                width: Get.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Etat des lieux',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Faire le tour du véhicule',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: List.generate(
                    c.conditionListChecker.length, (index) =>
                      Obx(() {
                        return InkWell(
                          onTap: () {
                            index == 0 ? c.carCheck.value = !c.carCheck.value
                                : index == 1 ?
                            c.assurance.value = !c.assurance.value
                                : c.grayCard.value = !c.grayCard.value;

                          },
                          highlightColor: AppTheme.light,
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: Get.height / 12,
                            width: Get.width,
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: index == 0 && c.carCheck.value == true || index == 1 && c.assurance.value == true || index == 2 && c.grayCard.value == true ? AppTheme.light : AppTheme.primaryColor,
                            ),
                            child: Center(
                              child: SizedBox(
                                width: Get.width / 1.6,
                                child: Text(c.conditionListChecker[index],
                                  maxLines: 2,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      overflow: TextOverflow.ellipsis,
                                      color: AppTheme.darkColor),
                                  textAlign: TextAlign.center,),
                              ),
                            ),
                          ),
                        );
                      }),),
                ),
              ),
              SizedBox(
                width: Get.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Vérifier l’état de l’intérieur du véhicule au départ',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(
                        color: AppTheme.darkColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SfSlider(
                activeColor: AppTheme.primaryColor,
                inactiveColor: AppTheme.primaryColor,
                thumbIcon: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppTheme.redColor,
                    shape: BoxShape.circle
                  ),
                ),
                min: 0.0,
                max: 40.0,
                value: c.carState.value,
                interval: 10,
                stepSize: 10,
                showTicks: false,
                showLabels: false,
                enableTooltip: true,
                tooltipTextFormatterCallback: (dynamic actualValue, String formattedText) {
                  return c.selectedCarState.value;
                },
                minorTicksPerInterval: 1,
                onChanged: (dynamic value) {
                  // print(value.runtimeType);
                  c.carState(value);

                  if(value < 10){
                    c.selectedCarState.value = 'Mauvais';
                  }else if(value < 20){
                    c.selectedCarState.value = 'Médiocre';
                  }else if(value < 30){
                    c.selectedCarState.value = 'Moyen';
                  }else if(value < 40){
                    c.selectedCarState.value = 'Bon';
                  }else{
                    c.selectedCarState.value = 'Trés propre';
                  }
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(c.listRangeStateCar.length, (index) => Text(c.listRangeStateCar[index],  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 9,
                      fontWeight: FontWeight.w900),)),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: Get.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Veuillez  prendre 8 photos du véhicules',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(
                        color: AppTheme.darkColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              _buildBody(),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBodyButtons() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(29)),
            // splashColor: const Color(0xFFEEEEEE),
            onTap: () {
              //open bottom sheet
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
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: Get.width / 2.2,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(29)),
              color: AppTheme.primaryColor,
            ),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(29)),
              // splashColor: const Color(0xFFEEEEEE),
              onTap: () {
                //open bottom sheet
                Get.to(() => ContractStep4());
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
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          GridView.builder(
            key: Get.keys[2],
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: c.imagesList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              mainAxisExtent: 120,
            ),
            itemBuilder: (context, index) {
              return ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(AppTheme.light),
                    overlayColor: MaterialStateProperty.all(Colors
                        .transparent),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
                  ),
                  onPressed: () {
                    // c.selectedPlaces.value = c.placesList[index];
                  },
                  child: SizedBox(
                    width: Get.width / 1.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${c.imagesList[index]} ${index == c.imagesList.length -1 ? '+' : ''}",
                            style: TextStyle(
                                fontSize: 14,
                                color: AppTheme.darkColor)),
                        const SizedBox(height: 10,),
                        Icon(Icons.camera_alt_outlined, size: 40, color: AppTheme.darkColor.withOpacity(0.4),)
                      ],
                    ),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
