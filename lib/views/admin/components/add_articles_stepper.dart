import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/addArticles/add_articles_controller.dart';
import 'package:get/get.dart';
import 'package:linear_step_indicator/linear_step_indicator.dart';

import 'another_stepper_page.dart';

class AddArticlesStepper extends StatefulWidget {
  const AddArticlesStepper({Key? key}) : super(key: key);

  @override
  State<AddArticlesStepper> createState() => _AddArticlesStepperState();
}

class _AddArticlesStepperState extends State<AddArticlesStepper> {
  PageController _pageController = PageController();
  AddArticlesController controller = Get.put(AddArticlesController());

  final int initialPage = 0;
  final int STEPS = 5;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const StepperArticles(title: 'Deposer votre annonce',);
  }
}
