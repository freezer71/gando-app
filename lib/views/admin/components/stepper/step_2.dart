import 'package:flutter/material.dart';
import 'package:gando/controllers/addArticles/add_articles_controller.dart';
import 'package:get/get.dart';

import '../../../../config/textstyle.dart';

class Step2 extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Step2State();
  }

}

class Step2State extends State<Step2> {
  static final form2 = GlobalKey<FormState>();
  static TextEditingController controllerEmail = TextEditingController();
  static TextEditingController controllerAddress = TextEditingController();
  static TextEditingController controllerMobileNo = TextEditingController();

  final c = Get.put(AddArticlesController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Form(
          key: form2,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: <Widget>[
              _buildHeader(context),
              const SizedBox(
                height: 10,
              ),
              _buildBody(context),
            ],
          ),
        )
    );
  }


  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          Text('Photos Conforme',
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(
                  color: AppTheme.darkColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w900)),
          const SizedBox(
            height: 10,
          ),
          Text('Pour une bonne compréhension  de la location,\nveuillez prendre des photos quilitative de votre véhicule.', style: Theme
              .of(context)
              .textTheme
              .bodyText2!
              .copyWith(
              color: AppTheme.darkColor,
              fontSize: 12,
              fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
  Widget _buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: GridView.builder(
              key: Get.keys[2],
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: c.imagesList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: 120,
              ),
              itemBuilder: (context, index) {
                return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(AppTheme.light),
                      overlayColor: MaterialStateProperty.all(Colors
                          .transparent),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                    ),
                    onPressed: () {
                      // c.selectedPlaces.value = c.placesList[index];
                    },
                    child: SizedBox(
                      width: Get.width / 1.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${c.imagesList[index]} ${index == c.imagesList.length -1 ? '+' : ''}",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.darkColor)),
                          const SizedBox(height: 10,),
                          Icon(Icons.camera_alt_outlined, size: 40, color: AppTheme.darkColor.withOpacity(0.4),)
                        ],
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }

}