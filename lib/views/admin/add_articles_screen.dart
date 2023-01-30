import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/addArticles/add_articles_controller.dart';
import 'package:gando/views/admin/components/add_articles_stepper.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:linear_step_indicator/linear_step_indicator.dart';

class AddArticlesScreen extends GetView<AddArticlesController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddArticlesController());
    return const AddArticlesStepper();
  }

  Widget buildBody(context) => Scaffold(
    backgroundColor: AppTheme.backgroundColor,
    appBar: AppBar(
      backgroundColor: Colors.red,
      centerTitle: true,
      elevation: 6,
      automaticallyImplyLeading: true,
      leading: IconButton(onPressed: (){
        Get.back();
      }, icon: Icon(Icons.arrow_back_ios_outlined, color: AppTheme.darkColor,),),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      title: Center(
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppTheme.darkColor,
          ),
          margin: EdgeInsets.zero,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            'Déposer une annonce',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              overflow: TextOverflow.visible,
              color: AppTheme.darkColor,
            ),
          ),
        ),
      ),
    ),
    extendBody: true,
    extendBodyBehindAppBar: false,
    body: Obx(() => Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: Expanded(
        child: Stepper(
          type: StepperType.horizontal,
          steps: buildStep(context),
          physics: BouncingScrollPhysics(),
          currentStep: controller.currentStep.value,
          onStepContinue: () {
            if (controller.currentStep.value ==
                buildStep(context).length - 1) {
              print("Send data to server");
            } else {
              controller.currentStep.value++;
            }
          },
          onStepCancel: () {
            controller.currentStep.value == 0
                ? null
                : controller.currentStep.value--;
          },
          onStepTapped: (index) {
            controller.currentStep.value = index;
          },
          controlsBuilder: (context, controls) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: AppTheme.redColor,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: Text(controller.currentStep.value ==
                          buildStep(context).length - 1
                          ? "Submit"
                          : "Next"),
                      onPressed: controls.onStepContinue,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  if (controller.currentStep.value != 0)
                    Expanded(
                      child: ElevatedButton(
                        child: Text("Previous"),
                        onPressed: controls.onStepCancel,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    )),
  );

  List<Step> buildStep(context) {
    return [
      buildStepContent(context, 'Etape', Container(), 1),
      buildStepContent(context, 'Etape', Container(), 2),
      buildStepContent(context, 'Etape', Container(), 3),
      buildStepContent(context, 'Etape', Container(), 4),
      buildStepContent(context, 'Etape', Container(), 5),
    ];
  }

  Step buildStepContent(
      BuildContext context, String title, Widget content, int index) {
    return Step(
      title: Container(
        child: Text(
          index == 3 ? 'Publier' : '$title $index',
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 6,
              color: AppTheme.darkColor),
        ),
      ),
      content: content,
      isActive: controller.currentStep.value >= index,
      state: controller.currentStep.value > index
          ? StepState.complete
          : StepState.indexed,
    );
  }
}
