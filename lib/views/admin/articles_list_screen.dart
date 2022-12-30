import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/views/admin/add_articles_screen.dart';
import 'package:gando/views/admin/calendar_screen.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../config/constants.dart';
import '../../models/car.dart';
import '../../models/profile_seller.dart';
import 'components/add_articles_stepper.dart';
import 'edit_article_screen.dart';

class ArticleListScreen extends StatefulWidget {
  const ArticleListScreen({Key? key}) : super(key: key);

  @override
  State<ArticleListScreen> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {

  final List listItems = [
    {'image': 'assets/images/bentley.png'},
    {'image': 'assets/images/cadillac.png'},
    {'image': 'assets/images/maserati.png'},
    {'image': 'assets/images/rolls_royce.png'},
  ];
  late Car car;
  @override
  void initState() {
    super.initState();
    car = Car(
      'assets/images/rolls_royce.png',
      800,
      'lorem ipsum rem ipsum  ',
      'maseratti',
      'co2',
      '2 L',
      LatLng(13.05, 77.53),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  Widget buildBody()=> Scaffold(
    backgroundColor: AppTheme.backgroundColor,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Text(
        'Mes annonces',
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 18,
            overflow: TextOverflow.ellipsis,
            color: AppTheme.darkColor
        ),
      ),
    ),
    body: Stack(
      children: [
        Container(
          child: ListView(
            children: List.generate(
              listItems.length,
                  (index) => Dismissible(
                key: ObjectKey(index),
                direction: DismissDirection.endToStart,
                onDismissed: (v) {
                  Get.defaultDialog(
                      backgroundColor: AppTheme.backgroundColor,
                      title: 'Supprimer',
                      middleText:
                      'Voulez-vous vraiment supprimer cette annonce',
                      middleTextStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        overflow: TextOverflow.visible,
                        color: AppTheme.darkColor,
                      ),
                      titleStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis,
                        color: AppTheme.darkColor,
                      ),
                      actions: [
                        SizedBox(width: Get.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('Annuler', style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                  color: AppTheme.redColor,
                                ),),
                              ),
                              TextButton(
                                onPressed: () {
                                  // removeAds(index);
                                },
                                child: Text('Supprimer', style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                  color: AppTheme.primaryColor,
                                ),),
                              )
                            ],
                          ),)
                      ]
                  );
                },
                background: buildSwipeActionLeft(),
                secondaryBackground: buildSwipeActionRight(),
                child: Card(
                  color: AppTheme.darkColor,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: SizedBox(
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width / 22,
                        ),
                        Container(
                          height: Get.height / 6,
                          width: Get.width / 2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              repeat: ImageRepeat.noRepeat,
                              alignment: Alignment.center,
                              image:
                              AssetImage(listItems[index]['image']),
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        Container(
                          width: Get.width / 8,
                          height: Get.height / 6,
                          decoration: BoxDecoration(
                              color: AppTheme.redColor,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: [
                              IconButton( onPressed: (){
                                Get.to(() => EditArticleScreen(article: car,));
                              }, icon: const Icon(Icons.edit)),

                              IconButton( onPressed: (){
                                Get.to(() => CalendarScreen());
                              }, icon: const Icon(Icons.calendar_month)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
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
    ),);

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

  void dismissItem(BuildContext context, int index, DismissDirection direction){
    setState(() {
      listItems.removeAt(index);
    });
  }
}
