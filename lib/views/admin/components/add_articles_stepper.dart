import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/addArticles/add_articles_controller.dart';
import 'package:get/get.dart';
import 'package:linear_step_indicator/linear_step_indicator.dart';

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
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        automaticallyImplyLeading: true,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Text(
          'Deposer une annonce',
          textAlign: TextAlign.center,
          style: Theme
              .of(context)
              .textTheme
              .bodyText2!
              .copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            overflow: TextOverflow.visible,
            color: AppTheme.backgroundColor,
          ),
        ),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            child: StepIndicatorPageView(
              steps: STEPS,
              physics: const NeverScrollableScrollPhysics(),
              indicatorPosition: IndicatorPosition.top,
              labels: List<String>.generate(
                  STEPS, (index) =>
              index == STEPS - 1
                  ? "Publier"
                  : "Etape ${index + 1}"),
              activeLabelStyle: Theme
                  .of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 13,
                overflow: TextOverflow.visible,
                color: AppTheme.primaryColor,
              ),
              inActiveLabelStyle: Theme
                  .of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 13,
                overflow: TextOverflow.visible,
                color: AppTheme.darkColor.withOpacity(0.6),
              ),
              controller: _pageController,
              complete: () {
                //typically, you'd want to put logic that returns true when all the steps
                //are completed here

                return Future.value(false);
              },
              children: List<Widget>.generate(
                STEPS,
                    (index) =>
                    Column(
                      children: [
                        Container(
                          width: Get.width,
                          height: Get.height / 1.70,
                          child: Center(
                            child: Text(
                              index == STEPS - 1 ? "Publier" : "Page ${index + 1}",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.darkColor),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: Get.width,
                            height: Get.height,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                index == initialPage ? Wrap() : ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      AppTheme.redColor,),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                30))),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (_pageController.hasClients) {
                                        _pageController.previousPage(duration: const Duration(milliseconds: 300),curve: Curves.easeIn);
                                      }
                                    });
                                  },
                                  child: Container(
                                    width: Get.width / 3,
                                    height: Get.height / 14,
                                    child: const Center(child: Text('Précedent')),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      AppTheme.primaryColor,),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                30))),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (_pageController.hasClients) {
                                        _pageController.nextPage(duration: const Duration(milliseconds: 300),curve: Curves.easeIn);
                                      }
                                    });
                                  },
                                  child: Container(
                                    width: Get.width / 3,
                                    height: Get.height / 14,
                                    child: Center(child: Text(index == STEPS -1 ? 'Terminer' : 'Suivant')),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
              ),
            ),
          ),
          // Positioned(
          //   top: Get.height / 2.3,
          //   child: SizedBox(
          //     width: Get.width,
          //     height: Get.height,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         ElevatedButton(
          //           style: ButtonStyle(
          //             backgroundColor: MaterialStateProperty.all(
          //               AppTheme.redColor,),
          //             shape: MaterialStateProperty.all(
          //                 RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(
          //                         30))),
          //           ),
          //           onPressed: () {
          //            setState(() {
          //              if (_pageController.hasClients) {
          //                _pageController.previousPage(duration: const Duration(milliseconds: 300),curve: Curves.easeIn);
          //              }
          //            });
          //           },
          //           child: Container(
          //             width: Get.width / 3,
          //             height: Get.height / 14,
          //             child: const Center(child: Text('Précedent')),
          //           ),
          //         ),
          //         ElevatedButton(
          //           style: ButtonStyle(
          //             backgroundColor: MaterialStateProperty.all(
          //               AppTheme.primaryColor,),
          //             shape: MaterialStateProperty.all(
          //                 RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(
          //                         30))),
          //           ),
          //           onPressed: () {
          //            setState(() {
          //              if (_pageController.hasClients) {
          //                _pageController.nextPage(duration: const Duration(milliseconds: 300),curve: Curves.easeIn);
          //              }
          //            });
          //           },
          //           child: Container(
          //             width: Get.width / 3,
          //             height: Get.height / 14,
          //             child: Center(child: Text('Suivant')),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
