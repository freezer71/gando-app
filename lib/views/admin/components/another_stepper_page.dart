import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gando/controllers/addArticles/add_articles_controller.dart';
import 'package:gando/views/admin/components/stepper/step_4.dart';
import 'package:get/get.dart';

import '../../../config/textstyle.dart';
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
  var currentStep = 0;

  final c = Get.put(AddArticlesController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mapData = HashMap<String, String>();
    mapData["first_name"] = Step1State.controllerFirstName.text;
    mapData["last_name"] = Step1State.controllerLastName.text;
    mapData["date_of_birth"] = Step1State.controllerDateOfBirth.text;
    mapData["gender"] = Step1State.controllerGender.text;

    mapData["email"] = Step2State.controllerEmail.text;
    mapData["address"] = Step2State.controllerAddress.text;
    mapData["mobile_no"] = Step2State.controllerMobileNo.text;

    List<Step> steps = [
      Step(
        title: Container().marginZero.paddingZero,
        label: Text('Etape 1', style: Theme.of(context).textTheme.bodyText2!.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          overflow: TextOverflow.visible,
          color: AppTheme.darkColor,
        )),
        content: Step1(),
        state: currentStep == 0 ? StepState.editing : StepState.indexed,
        isActive: currentStep == 0 ? true : false,
      ),
      Step(
        title: Container().marginZero.paddingZero,
        label: Text('Etape 2', style: Theme.of(context).textTheme.bodyText2!.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          overflow: TextOverflow.visible,
          color: AppTheme.darkColor,
        ),).paddingZero,
        content: Step2(),
        state: currentStep == 1 ? StepState.editing : StepState.indexed,
        isActive: currentStep == 1 ? true : false,
      ),
      Step(
        title: Container().marginZero.paddingZero,
        label: Text('Etape 3', style: Theme.of(context).textTheme.bodyText2!.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          overflow: TextOverflow.visible,
          color: AppTheme.darkColor,
        ),).paddingZero,
        content: Step3(),
        state: currentStep == 2 ? StepState.editing : StepState.indexed,
        isActive: currentStep == 2 ? true : false,
      ),
      Step(
        title: Container().marginZero.paddingZero,
        label: Text('Etape 4', style: Theme.of(context).textTheme.bodyText2!.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          overflow: TextOverflow.visible,
          color: AppTheme.darkColor,
        ),).paddingZero,
        content: Step4(),
        state: currentStep == 3 ? StepState.editing : StepState.indexed,
        isActive: currentStep == 3 ? true : false,
      ),
      Step(
        label: Text('Publier', style: Theme.of(context).textTheme.bodyText2!.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          overflow: TextOverflow.visible,
          color: AppTheme.darkColor,
        )),
        title: Container().marginZero.paddingZero,
        content: Upload(mapData),
        state: StepState.complete,
        isActive: currentStep == 4 ? true : false,
      ),
    ];

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: CustomAppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios_outlined, color: AppTheme.darkColor,),),
        title: widget.title,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        padding: const EdgeInsets.only(top: 80.0),
        child: Stepper(
          currentStep: currentStep,
          steps: steps,
          margin: EdgeInsets.zero,
          type: StepperType.horizontal,
          onStepTapped: (step) {
            setState(() {
              currentStep = step;
            });
          },
          controlsBuilder: (context, controls){
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  if (currentStep != 0)
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 20)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )),
                            backgroundColor: MaterialStateProperty.all(AppTheme.redColor)
                        ),
                        child: const Text("Précédent"),
                        onPressed: controls.onStepCancel,
                      ),
                    ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 20)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                        backgroundColor: MaterialStateProperty.all(AppTheme.primaryColor)
                      ),
                      onPressed: controls.onStepContinue,
                      child: Text(currentStep == steps.length - 1
                          ? "Publier"
                          : "Suivant"),
                    ),
                  ),

                ],
              ),
            );
          },
          onStepContinue: () {
            setState(() {
              if (currentStep < steps.length - 1) {
                if (currentStep == 0 && Step1State.form1.currentState!.validate()) {
                  if(c.selectedFile.value != null){
                    if(c.selectedEquipments.isNotEmpty){
                     currentStep = currentStep + 1;
                     printInfo(info: "currentStep: $currentStep");
                    }else{
                      _showErrorDialog("Veuillez choisir au moins un équipement\n s'il vous plait");
                    }
                  }else{
                    _showErrorDialog("Veuillez prendre une image du controle technique");
                  }
                } else if (currentStep == 1) {
                  if(c.selectedFile1.value != null &&
                      c.selectedFile2.value != null &&
                      c.selectedFile3.value != null &&
                      c.selectedFile4.value != null &&
                      c.selectedFile5.value != null){
                    Step2State.form2.currentState!.save();
                    currentStep = currentStep + 1;
                  }else{
                    _showErrorDialog("Veuillez choisir les images du véhicule s'il vous plait");
                  }
                } else if (currentStep == 2 &&
                    Step3State.form3.currentState!.validate()) {
                  currentStep = currentStep + 1;
                } else if (currentStep == 3 &&
                    Step4State.form4.currentState!.validate()) {
                  currentStep = currentStep + 1;
                }else {
                  // show modal error:
                  _showErrorDialog("Veuillez remplir tous les champs");
                }
              } else {
                currentStep = 0;
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (currentStep > 0) {
                currentStep = currentStep - 1;
              } else {
                currentStep = 0;
              }
            });
          },
        ),
      ),
    );
  }

  _showErrorDialog(text){
    Get.dialog(
      AlertDialog(
        backgroundColor: AppTheme.light,
        title: Text("Erreur", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: AppTheme.redColor,
          fontWeight: FontWeight.w800,
        ),),
        content: Text(text, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: AppTheme.darkColor,
        ),),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("OK", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppTheme.darkColor,
            ),),
          )
        ],
      ),
    );
  }
}
