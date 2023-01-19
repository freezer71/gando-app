import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:expandable_text/text_parser.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/contract_controller/contract_controller.dart';
import 'package:gando/generated/assets.dart';
import 'package:gando/views/products/booking/contract/contract_step_7.dart';
import 'package:gando/widget/customTextFormField.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ContractStep6 extends StatelessWidget {
  ContractStep6({Key? key}) : super(key: key);

  final c = Get.put(ContractController());

  final double carState = 40.0;

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
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          children: [
            SizedBox(
              width: Get.width,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Récapitulatif',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: AppTheme.darkColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Divider(height: 10, color: AppTheme.darkColor,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width,
                  child: Text(
                    'Marque et modele'.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: Get.width,
                  child: Text(
                    'Date de départ',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  width: Get.width,
                  child: Text(
                    'Jeudi 01 septembre à 14h30',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: Get.width,
                  child: Text(
                    'Date de retour',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  width: Get.width,
                  child: Text(
                    'Jeudi 01 septembre à 14h30',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                SizedBox(height: 20,),
                SizedBox(
                  width: Get.width,
                  child: Text(
                    'Kilomètres inclus',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  width: Get.width,
                  child: Text(
                    '250 Km',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 20,),
                Divider(height: 10, color: AppTheme.darkColor,),
                SizedBox(
                  width: Get.width,
                  child: Text(
                    'Etat interieur',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  width: Get.width,
                  child: Text(
                    'Moyen',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: Get.width,
                  child: Text(
                    'Photos du véhicule',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                _buildBody(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getLinearGauge() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SfRadialGauge(axes: [
        RadialAxis(
            axisLineStyle: const AxisLineStyle(
              thickness: 0.2,
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            showTicks: false,
            showLabels: true,
            maximum: 40,
            minimum: 0,
            interval: 10,
            minorTicksPerInterval: 10,
            pointers: [
              RangePointer(
                color: AppTheme.primaryColor,
                  value: double.parse(c.annotationValue.value),
                  onValueChanged: onPointerValueChanged,
                  enableDragging: true,
                  width: 0.2,
                  animationType: AnimationType.easeInCirc,
                  sizeUnit: GaugeSizeUnit.factor),
            ],
            annotations: [
              GaugeAnnotation(
                  widget: Row(
                    children: [
                      Text(
                        '${c.annotationValue.value}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Times',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00A8B5)),
                      ),
                      const Text(
                        ' Litres',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Times',
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF00A8B5)),
                      )
                    ],
                  ),
                  positionFactor: 0.95,
                  angle: 0)
            ])
      ]),
    );
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
                Get.off(() => ContractStep7());
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
      padding: const EdgeInsets.symmetric(horizontal: 5 , vertical: 10),
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
                    backgroundColor: MaterialStateProperty.all(AppTheme.light),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
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
                        Text(
                            "${c.imagesList[index]} ${index == c.imagesList.length - 1 ? '+' : ''}",
                            style: TextStyle(
                                fontSize: 14, color: AppTheme.darkColor)),
                        const SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 40,
                          color: AppTheme.darkColor.withOpacity(0.4),
                        )
                      ],
                    ),
                  ));
            },
          ),
        ],
      ),
    );
  }

  void onPointerValueChanged(double value) {
    final int _value = value.toInt();
    c.annotationValue.value = '${value.toInt()}';
  }
}
