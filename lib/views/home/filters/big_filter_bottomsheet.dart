import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:get/get.dart';
import 'package:text_form_field_wrapper/text_form_field_wrapper.dart';

class Filters extends StatelessWidget {
  Filters({Key? key}) : super(key: key);

  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  TextEditingController minYearController = TextEditingController();
  TextEditingController maxYearController = TextEditingController();

  final List carTypeList = [
    {'title': 'Citadine'},
    {'title': '4x4'},
    {'title': 'Familiale'},
  ];

  final List carTypeList2 = [
    {'title': 'Utilitaire'},
    {'title': 'Coupé'},
    {'title': 'Berline'},
  ];

  final List carTypeList3 = [
    {'title': 'Cabriolet'},
    {'title': 'Minibus'},
    {'title': 'Autre(s)'},
  ];

  final List speedBox = [
    {'title': 'Automatique'},
    {'title': 'Manuelle'},
  ];

  final List fuelList = [
    {'title': 'Essence'},
    {'title': 'Diesel'},
    {'title': 'Hybride'},
    {'title': 'Electrique'},
    {'title': 'Autre(s)'},
  ];

  final List carNumberDoor = [
    2,3,4,5,6,7
  ];

  final List carNumberSit = [
    1,2,3,4,5,6,7,8,9
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 900,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: AppTheme.backgroundColor,
      ),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          header(context),
          Divider(color: AppTheme.secondaryColor.withOpacity(0.3), height: 30,thickness: 1.3,),
          section1(context),
          Divider(color: AppTheme.secondaryColor.withOpacity(0.3), height: 30,thickness: 1.3,),
          section2(context),
          Divider(color: AppTheme.secondaryColor.withOpacity(0.3), height: 30,thickness: 1.3,),
          section3(context),
          Divider(color: AppTheme.secondaryColor.withOpacity(0.3), height: 30,thickness: 1.3,),
          section4(context),
        ],
      ),
    );
  }

  Widget header(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: Get.width / 2.4,
          ),
          Text(
            'Filtre',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis,
                  color: AppTheme.secondaryColor,
                ),
          ),
          Expanded(child: SizedBox()),
          Container(
            child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.close,
                  color: AppTheme.secondaryColor,
                )),
          ),
        ],
      ),
    );
  }

  Widget section1(BuildContext context) {
    return SizedBox(
      height: Get.height /5.5,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                child: ActionChip(
                  elevation: 2,
                  autofocus: true,
                  labelPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                  backgroundColor: AppTheme.primaryColor,
                  labelStyle:  Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                    color: AppTheme.backgroundColor,
                  ),
                  disabledColor: AppTheme.secondaryColor.withOpacity(0.5),
                  pressElevation: 8,
                  label: Text('Prix croissant'),
                  avatar: const Icon(Icons.check),
                  onPressed: (){

                  },
                ),
              ),
              SizedBox(
                child: ActionChip(
                  elevation: 2,
                  labelPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  backgroundColor: AppTheme.primaryColor,
                  labelStyle:  Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                    color: AppTheme.backgroundColor,
                  ),
                  disabledColor: AppTheme.secondaryColor.withOpacity(0.5),
                  pressElevation: 8,
                  label: Text('Prix décroissant'),
                  avatar: const Icon(Icons.check),
                  onPressed: (){

                  },
                ),
              ),

            ],
          ),
          SizedBox(height: 20,),
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
               Row(
                 verticalDirection : VerticalDirection.down,
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   Container(
                     width: 150,
                     child: TextFormFieldWrapper(
                       formField: TextFormField(
                         controller: minController,
                         keyboardType: TextInputType.number,
                         autofocus: false,
                         decoration: InputDecoration(
                             border: InputBorder.none,
                             hintText: 'Min',
                             hintStyle: TextStyle(
                                 color: AppTheme.secondaryColor.withOpacity(0.5)
                             )
                         ),
                       ),
                       position: TextFormFieldPosition.alone,
                     ),
                   ),
                   Container(
                     width: 150,
                     child: TextFormFieldWrapper(
                       formField: TextFormField(
                         controller: maxController,
                         keyboardType: TextInputType.number,
                         autofocus: false,
                         decoration: InputDecoration(
                             border: InputBorder.none,
                           hintText: 'Max',
                           hintStyle: TextStyle(
                             color: AppTheme.secondaryColor.withOpacity(0.5)
                           )
                         ),
                       ),
                       position: TextFormFieldPosition.alone,
                     ),
                   ),
                 ],
               )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget section2(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Type de véhicule',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis,
                  color: AppTheme.secondaryColor,
                ),
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) => buildCarType(context, carTypeList[index]['title']),),
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) => buildCarType(context, carTypeList2[index]['title']),),
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) => buildCarType(context, carTypeList3[index]['title']),),
          ),
        ],
      ),
    );
  }

  Widget section3(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Boite de vitesse',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              overflow: TextOverflow.ellipsis,
              color: AppTheme.secondaryColor,
            ),
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(2, (index) => buildCarType(context, speedBox[index]['title']),),
          ),
        ],
      ),
    );
  }

  Widget section4(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Nombre de portes',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              overflow: TextOverflow.ellipsis,
              color: AppTheme.secondaryColor,
            ),
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(carNumberDoor.length-3, (index) => buildCarType(context, carNumberDoor[index]),),
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(carNumberDoor.indexOf(2), (index) => buildCarType(context, carNumberDoor[index]),),
          ),
        ],
      ),
    );
  }

  Widget buildCarType(context, num){
    return SizedBox(
      child: ActionChip(
        elevation: 2,
        labelPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
        backgroundColor: AppTheme.backgroundColor,
        labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          overflow: TextOverflow.ellipsis,
          color: AppTheme.backgroundColor,
        ),
        disabledColor: AppTheme.secondaryColor.withOpacity(0.5),
        pressElevation: 8,
        label: Text(num.toString(), style: Theme.of(context).textTheme.bodyText2!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          overflow: TextOverflow.ellipsis,
          color: AppTheme.darkColor,
        ),),
        onPressed: (){

        },
      ),
    );
  }
}
