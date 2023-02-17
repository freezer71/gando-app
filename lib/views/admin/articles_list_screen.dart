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
import '../../widget/appBarWidget.dart';
import 'components/add_articles_stepper.dart';
import 'edit_article_screen.dart';

class ArticleListScreen extends StatefulWidget {
  final int? id;
  ArticleListScreen({this.id, Key? key}) : super(key: key);

  @override
  State<ArticleListScreen> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  final controller = Get.put(UserController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  Widget buildBody() => Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: CustomAppBar(
          title: 'Mes annonces',
        ),
        body: Stack(
          children: [
            Container(
                child: FutureBuilder(
              future: controller.getUserCarList(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                // check connection state
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  // check if there is an error
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    if (snapshot.hasData) {
                      // check if the data is empty
                      if (snapshot.data!) {
                        return ListView.builder(
                          itemCount: snapshot.data!.userProfileSeller!.length,
                          itemBuilder: (BuildContext context, int index) {
                            ProfileSeller profileSeller =
                                snapshot.data!.userProfileSeller![index];
                            return Dismissible(
                              key: Key(
                                  controller.userCarList[index].id.toString()),
                              direction: DismissDirection.horizontal,
                              background: buildSwipeActionLeft(),
                              secondaryBackground: buildSwipeActionRight(),
                              onDismissed: (direction) {
                                dismissItem(context, index, direction);
                              },
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                      controller
                                          .userCarList[index].images.avant34,
                                    ),
                                  ),
                                  title: Text(
                                    controller.userCarList[index].brand,
                                    // style: AppTheme.title,
                                  ),
                                  subtitle: Text(
                                    controller.userCarList[index].description,
                                    // style: AppTheme.subtitle,
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      // Get.to(() => EditArticleScreen(
                                      //       id: profileSeller.id,
                                      //     ));
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: AppTheme.primaryColor,
                                    ),
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
            )),
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
    setState(() {
      controller.userCarList.removeAt(index);
    });
  }
}
