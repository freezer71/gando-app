import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/views/admin/add_articles_screen.dart';
import 'package:gando/views/admin/calendar_screen.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart';

import '../../config/constants.dart';
import '../../controllers/user/user_controller.dart';
import '../../generated/assets.dart';
import '../../models/Car.dart';
import '../../models/ProfileSeller.dart';
import '../../models/UserCar.dart';
import '../../services/auth/get_user_car.dart';
import '../../widget/appBarWidget.dart';
import 'components/add_articles_stepper.dart';
import 'edit_article_screen.dart';

class ArticleListScreen extends GetView<UserController> {
  ArticleListScreen({super.key});

  late List<Car> userCarList;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => UserController());
    return buildBody();
  }

  Widget buildBody() => Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: CustomAppBar(
          title: 'Mes annonces',
        ),
        body: Stack(
          children: [
            FutureBuilder(
              future: controller.getCarList,
              initialData: controller.userCarList,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                userCarList = snapshot.data;
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text('Press button to start.');
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}',
                            style: Theme.of(context).textTheme.headline6),
                      );
                    } else {
                      if (snapshot.hasData) {
                        // if userCarList.isEmpty
                        if (userCarList.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(Assets.lotties98979EmpyList,
                                    width: 200, height: 200),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Aucune annonce',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                      color:
                                      AppTheme.darkColor.withOpacity(.5),
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          );
                        }
                        // check if the data is empty
                        if (snapshot.data.length != 0 &&
                            snapshot.data != null) {
                          return ListView.builder(
                            itemCount: userCarList.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: Key(userCarList[index].id!),
                                direction: DismissDirection.endToStart,
                                onDismissed: (v) {
                                  _showModalDialog();
                                },
                                background: buildSwipeActionLeft(),
                                secondaryBackground: buildSwipeActionRight(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      repeat: ImageRepeat.noRepeat,
                                      alignment: Alignment.center,
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(userCarList[index].images!.avant34!,),
                                    ),
                                    color: AppTheme.redColor,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10),
                                  child: SizedBox(
                                    width: Get.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: Get.width / 8,
                                          height: Get.height / 6,
                                          decoration: BoxDecoration(
                                              color: AppTheme.darkColor,
                                              borderRadius:
                                              const BorderRadius.only(
                                                  topRight:
                                                  Radius.circular(20),
                                                  bottomRight:
                                                  Radius.circular(20))),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    Get.to(() => EditArticleScreen(car: userCarList[index],));
                                                  },
                                                  icon: const Icon(Icons.edit)),
                                              IconButton(
                                                  onPressed: () {
                                                    Get.to(
                                                            () => CalendarScreen());
                                                  },
                                                  icon: const Icon(
                                                      Icons.calendar_month)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: Column(
                              children: [
                                SizedBox(height: Get.height * .2),
                                LottieBuilder.asset(
                                  Assets.lotties98979EmpyList,
                                  width: 200,
                                  height: 200,
                                ),
                                Text(
                                  'Vous n\'avez pas encore d\'annonces',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                    overflow: TextOverflow.fade,
                                    color: AppTheme.darkColor.withOpacity(.3),
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          );
                        }
                      } else {
                        return Center(
                          child: Column(
                            children: [
                              SizedBox(height: Get.height * .2),
                              LottieBuilder.asset(
                                Assets.lotties98979EmpyList,
                                width: 200,
                                height: 200,
                              ),
                              Text(
                                'Vous n\'avez pas encore d\'annonces',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  overflow: TextOverflow.fade,
                                  color: AppTheme.darkColor.withOpacity(.3),
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        );
                      }
                    }
                }
              },
            ),
            Positioned(
              bottom: 100,
              width: Get.width,
              child: FloatingActionButton(
                backgroundColor: AppTheme.primaryColor,
                elevation: 6,
                onPressed: () {
                  Get.to(() => AddArticlesScreen());
                },
                child: Icon(
                  Icons.add,
                  color: AppTheme.backgroundColor,
                  size: 33,
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildSwipeActionLeft() => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: AppTheme.darkColor,
        child: const Icon(Icons.archive),
      );

  Widget buildSwipeActionRight() => Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: AppTheme.redColor,
        child: const Icon(Icons.restore_from_trash_rounded),
      );

  void dismissItem(
      BuildContext context, int index, DismissDirection direction) {
    controller.userCarList.removeAt(index);
  }

  Future _showModalDialog() {
    return Get.defaultDialog(
        backgroundColor: AppTheme.backgroundColor,
        title: 'Supprimer',
        middleText: 'Voulez-vous vraiment supprimer cette annonce',
        middleTextStyle: Theme.of(Get.context!).textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              overflow: TextOverflow.visible,
              color: AppTheme.darkColor,
            ),
        titleStyle: Theme.of(Get.context!).textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              overflow: TextOverflow.ellipsis,
              color: AppTheme.darkColor,
            ),
        actions: [
          SizedBox(
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'Annuler',
                    style: Theme.of(Get.context!).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis,
                          color: AppTheme.redColor,
                        ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // removeAds(index);
                  },
                  child: Text(
                    'Supprimer',
                    style: Theme.of(Get.context!).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis,
                          color: AppTheme.primaryColor,
                        ),
                  ),
                )
              ],
            ),
          )
        ]);
  }
}
