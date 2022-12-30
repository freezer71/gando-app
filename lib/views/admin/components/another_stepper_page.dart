import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gando/views/admin/components/stepper/step_4.dart';
import 'package:get/get.dart';

import '../../../config/textstyle.dart';
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
        isActive: true,
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
        isActive: true,
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
        isActive: true,
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
        isActive: true,
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
        isActive: true,
      ),
    ];

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios_outlined, color: AppTheme.darkColor,),),
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            overflow: TextOverflow.visible,
            color: AppTheme.darkColor,
          ),
        ),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.only(top: 80.0),
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
