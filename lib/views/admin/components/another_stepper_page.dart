import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gando/controllers/addArticles/add_articles_controller.dart';
import 'package:gando/views/admin/components/stepper/step_4.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../config/textstyle.dart';
import '../../../generated/assets.dart';
import '../../../widget/appBarWidget.dart';
import 'stepper/final_step.dart';
import 'stepper/step_1.dart';
import 'stepper/step_2.dart';
import 'stepper/step_3.dart';

class StepperArticles extends StatefulWidget {
  const StepperArticles({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<StepperArticles> createState() => _StepperArticlesState();
}

class _StepperArticlesState extends State<StepperArticles> {

  var mapData = HashMap<String, dynamic>();

  DateTime? _currentBackPressTime;

  final c = Get.put(AddArticlesController());

  late List<Step> steps;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      steps = [
        Step(
          title: Container().marginZero.paddingZero,
          label: Text('Etape 1', style: Theme
              .of(context)
              .textTheme
              .bodyText2!
              .copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            overflow: TextOverflow.visible,
            color: AppTheme.darkColor,
          )),
          content: Step1(),
          state: c.currentStep.value == 0 ? StepState.editing : StepState.indexed,
          isActive: c.currentStep.value == 0 ? true : false,
        ),
        Step(
          title: Container().marginZero.paddingZero,
          label: Text('Etape 2', style: Theme
              .of(context)
              .textTheme
              .bodyText2!
              .copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            overflow: TextOverflow.visible,
            color: AppTheme.darkColor,
          ),).paddingZero,
          content: Step2(),
          state: c.currentStep.value == 1 ? StepState.editing : StepState.indexed,
          isActive: c.currentStep.value == 1 ? true : false,
        ),
        Step(
          title: Container().marginZero.paddingZero,
          label: Text('Etape 3', style: Theme
              .of(context)
              .textTheme
              .bodyText2!
              .copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            overflow: TextOverflow.visible,
            color: AppTheme.darkColor,
          ),).paddingZero,
          content: Step3(),
          state: c.currentStep.value == 2 ? StepState.editing : StepState.indexed,
          isActive: c.currentStep.value == 2 ? true : false,

        ),
        Step(
          title: Container().marginZero.paddingZero,
          label: Text('Etape 4', style: Theme
              .of(context)
              .textTheme
              .bodyMedium!
              .copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            overflow: TextOverflow.visible,
            color: AppTheme.darkColor,
          ),).paddingZero,
          content: Step4(),
          state: c.currentStep.value == 3 ? StepState.editing : StepState.indexed,
          isActive: c.currentStep.value == 3 ? true : false,
        ),
        Step(
          label: Text('Publier', style: Theme
              .of(context)
              .textTheme
              .bodyText2!
              .copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            overflow: TextOverflow.visible,
            color: AppTheme.darkColor,
          )),
          title: Container().marginZero.paddingZero,
          content: Upload(mapData),
          state: StepState.complete,
          isActive: c.currentStep.value == 4 ? true : false,
        ),
      ];

      return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: CustomAppBar(
          leading: IconButton(onPressed: () {
            // pop scope with modal
            _onWillPop();
          },
            icon: Icon(
              Icons.arrow_back_ios_outlined, color: AppTheme.darkColor,),),
          title: widget.title,
        ),
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: WillPopScope(
          onWillPop: _onWillPop,
          child: Container(
            padding: const EdgeInsets.only(top: 80.0),
            child: Stepper(
              currentStep: c.currentStep.value,
              steps: steps,
              margin: EdgeInsets.zero,
              type: StepperType.horizontal,
              onStepTapped: (step) {
                c.currentStep.value = step;
              },
              controlsBuilder: (context, controls) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      if (c.currentStep.value != 0)
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(vertical: 20)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    )),
                                backgroundColor: MaterialStateProperty.all(
                                    AppTheme.redColor)
                            ),
                            onPressed: controls.onStepCancel,
                            child: const Text("Précédent"),
                          ),
                        ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(vertical: 20)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  )),
                              backgroundColor: MaterialStateProperty.all(
                                  AppTheme.primaryColor)
                          ),
                          onPressed: controls.onStepContinue,
                          child: c.isLoading.value ?
                                  const CircularProgressIndicator(
                                    color: Colors.white,
                                  ).marginZero.paddingZero
                              : Text(c.currentStep.value == steps.length - 1
                              ? "Publier"
                              : "Suivant"),
                        ),
                      ),

                    ],
                  ),
                );
              },
              onStepContinue: () async {
                // if (currentStep < steps.length - 1) {
                if (c.currentStep.value == 0 &&
                    Step1State.form1.currentState!.validate()) {
                  if (c.selectedFile.value != null) {
                    if (c.selectedEquipments.isNotEmpty) {
                      c.currentStep.value = c.currentStep.value + 1;
                      printInfo(info: "currentStep: ${c.currentStep.value}");
                    } else {
                      _showErrorDialog(
                          "Veuillez choisir au moins un équipement\n s'il vous plait");
                    }
                  } else {
                    _showErrorDialog(
                        "Veuillez prendre une image du controle technique");
                  }
                } else if (c.currentStep.value == 1) {
                  if (c.selectedFile1.value != null &&
                      c.selectedFile2.value != null &&
                      c.selectedFile3.value != null &&
                      c.selectedFile4.value != null &&
                      c.selectedFile5.value != null) {
                    Step2State.form2.currentState!.save();
                    c.currentStep.value = c.currentStep.value + 1;
                  } else {
                    _showErrorDialog(
                        "Veuillez choisir les images du véhicule s'il vous plait");
                  }
                } else if (c.currentStep.value == 2 &&
                    Step3State.form3.currentState!.validate()) {
                  Step3State.form3.currentState!.save();
                  c.currentStep.value = c.currentStep.value + 1;
                } else if (c.currentStep.value == 3 &&
                    Step4State.form4.currentState!.validate()) {
                  Step4State.form4.currentState!.save();
                  c.currentStep.value = c.currentStep.value + 1;
                  printInfo(info: "mapData: ${mapData.toString()}");
                  printInfo(
                      info: "FINAL STEP CALLLL =====>>>: ${c.currentStep.value}");
                } else if (c.currentStep.value == steps.length - 1 &&
                    UploadState.finalForm.currentState!.validate()) {
                  // upload data
                  await c.uploadData();
                } else {
                  // show modal error:
                  _showErrorDialog("Veuillez remplir tous les champs");
                }
              },
              onStepCancel: () {
                if (c.currentStep.value > 0) {
                  c.currentStep.value = c.currentStep.value - 1;
                } else {
                  c.currentStep.value = 0;
                }
              },
            ),
          ),
        ),
      );
    });
  }

  _showErrorDialog(text) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppTheme.light,
        title: Text("Erreur", style: Theme
            .of(context)
            .textTheme
            .bodyMedium!
            .copyWith(
          color: AppTheme.redColor,
          fontWeight: FontWeight.w800,
        ),),
        content: Text(text, style: Theme
            .of(context)
            .textTheme
            .bodyMedium!
            .copyWith(
          color: AppTheme.darkColor,
        ),),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("OK", style: Theme
                .of(context)
                .textTheme
                .bodyMedium!
                .copyWith(
              color: AppTheme.darkColor,
            ),),
          )
        ],
      ),
    );
  }


  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime!) > const Duration(seconds: 2)) {
      _currentBackPressTime = now;
      Get.defaultDialog(
        title: 'Voulez vous vraiment quitter l\'ajout de l\'annonce',
        titlePadding: const EdgeInsets.all(18.0),
        backgroundColor: AppTheme.light,
        titleStyle: TextStyle(
          color: AppTheme.darkColor,
          fontSize: 18,
          fontWeight: FontWeight.w900,
        ),
        content: Container(
          child: Column(
            children: [
              LottieBuilder.asset(Assets.zip15144AttentionSign,
                  width: 180, fit: BoxFit.contain),
              // Text(
              //   'Voulez vous vraiment quitter la création de votre boutique?',
              //   style: GlobalStyle.appBarTitle.copyWith(color: PRIMARY_COLOR),
              // ),
            ],
          ),
        ),
        contentPadding: const EdgeInsets.all(24.0),
        radius: 10.0,
        onConfirm: () => Future.value(true),
        onCancel: () => Future.value(false),
        confirm: Theme(
          data: Theme.of(context)
              .copyWith(colorScheme:  ColorScheme.light(primary: AppTheme.redColor)),
          child: ElevatedButton(
            onPressed: () => Get.back(closeOverlays: true),
            child: const Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 22.0, vertical: 4),
              child: Text(
                'Oui',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        cancel: Theme(
          data: Theme.of(context)
              .copyWith(colorScheme: ColorScheme.light(primary: AppTheme.primaryColor)),
          child: Container(
            child: ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                primary: AppTheme.primaryColor,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 4),
                child: Text(
                  'Non',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }
}
