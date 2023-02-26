import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../config/textstyle.dart';
import '../../../../controllers/addArticles/add_articles_controller.dart';

class Step4 extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Step4State();
  }
}

class Step4State extends State<Step4> {
  static final form4 = GlobalKey<FormState>();
  static TextEditingController controllerEmail = TextEditingController();
  static TextEditingController controllerAddress = TextEditingController();
  static TextEditingController controllerMobileNo = TextEditingController();

  ScrollController controller = ScrollController();

  final c = Get.put(AddArticlesController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Form(
          key: form4,
          autovalidateMode: AutovalidateMode.always,
          child: Container(
            width: Get.width,
            height: Get.height,
            padding: EdgeInsets.zero,
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                Text('Calendrier', style: Theme
                    .of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis,
                  color: AppTheme.darkColor,

                ), textAlign: TextAlign.center,),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: AppTheme.light,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ..._buildHeader(context),
                    ],
                  ),
                ),
                _buildCalender(),
                const SizedBox(height: 200,),
              ],
            ),
          ),
        )
    );
  }

  List<Widget> _buildHeader(context) =>
      [
        Container(
          child: Row(
            children: [
              Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                      color: AppTheme.backgroundColor,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          offset: const Offset(0, 2),
                          blurRadius: 2,
                        ),
                      ]
                  )
              ),
              const SizedBox(width: 10,),
              Text('Disponible', style: Theme
                  .of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                overflow: TextOverflow.ellipsis,
                color: AppTheme.darkColor,
              ),)
            ],
          ),
        ),
        Container(
          child: Row(
            children: [
              Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                    color: AppTheme.redColor,
                    borderRadius: BorderRadius.circular(5),
                  )
              ),
              SizedBox(width: 10,),
              Text('Indisponible', style: Theme
                  .of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: AppTheme.darkColor,
              ),)
            ],
          ),
        ),
        Container(
          child: Row(
            children: [
              Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  )
              ),
              SizedBox(width: 10,),
              Text('En location', style: Theme
                  .of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: AppTheme.darkColor,
              ),)
            ],
          ),
        ),
      ];

  Widget _buildCalender() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppTheme.light,
          ),
          child: SfDateRangePicker(
              initialSelectedRange: PickerDateRange(c.initialDate.value, c.initialDate.value),
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.range,
              selectionTextStyle: const TextStyle(color: Colors.white),
              selectionColor: Colors.blue,
              startRangeSelectionColor: AppTheme.redColor,
              endRangeSelectionColor: AppTheme.redColor,
              rangeSelectionColor: AppTheme.primaryColor,
              rangeTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
              yearCellStyle: DateRangePickerYearCellStyle(
                disabledDatesDecoration:BoxDecoration(
                    color: AppTheme.redColor,
                    border: Border.all(color: const Color(0xFFB6B6B6), width: 1),
                    shape: BoxShape.circle),
                disabledDatesTextStyle: const TextStyle(color: Colors.black),
                leadingDatesDecoration:BoxDecoration(
                    color: AppTheme.primaryColor,
                    border: Border.all(color: AppTheme.redColor, width: 1),
                    shape: BoxShape.circle),
                leadingDatesTextStyle: TextStyle(color: AppTheme.redColor,),
                textStyle:  TextStyle(color: AppTheme.darkColor,),
                todayCellDecoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    border: Border.all(color: AppTheme.redColor, width: 1),
                    shape: BoxShape.circle),
                todayTextStyle: TextStyle(color: AppTheme.light),
              )
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppTheme.light,
          ),
          child: SfDateRangePicker(
              initialSelectedRange: PickerDateRange(c.initialDate.value, c.initialDate.value),
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.range,
              selectionTextStyle: const TextStyle(color: Colors.white),
              selectionColor: Colors.blue,
              startRangeSelectionColor: AppTheme.primaryColor,
              endRangeSelectionColor: AppTheme.primaryColor,
              rangeSelectionColor: AppTheme.redColor,
              rangeTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
              yearCellStyle: DateRangePickerYearCellStyle(
                disabledDatesDecoration:BoxDecoration(
                    color: AppTheme.redColor,
                    border: Border.all(color: const Color(0xFFB6B6B6), width: 1),
                    shape: BoxShape.circle),
                disabledDatesTextStyle: const TextStyle(color: Colors.black),
                leadingDatesDecoration:BoxDecoration(
                    color: AppTheme.primaryColor,
                    border: Border.all(color: AppTheme.redColor, width: 1),
                    shape: BoxShape.circle),
                leadingDatesTextStyle: TextStyle(color: AppTheme.redColor,),
                textStyle:  TextStyle(color: AppTheme.darkColor,),
                todayCellDecoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    border: Border.all(color: AppTheme.redColor, width: 1),
                    shape: BoxShape.circle),
                todayTextStyle: TextStyle(color: AppTheme.light),
              )
          ),
        ),
      ],
    );
  }

}