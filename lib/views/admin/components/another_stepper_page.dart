import 'dart:collection';

import 'package:flutter/material.dart';
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
          currentStep: this.currentStep,
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
              padding: EdgeInsets.symmetric(vertical: 20),
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
                        child: Text("Précédent"),
                        onPressed: controls.onStepCancel,
                      ),
                    ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 20)),
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
                if (currentStep == 0 &&
                    Step1State.form1.currentState!.validate()) {
                  currentStep = currentStep + 1;
                } else if (currentStep == 1 &&
                    Step2State.form2.currentState!.validate()) {
                  currentStep = currentStep + 1;
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
}
