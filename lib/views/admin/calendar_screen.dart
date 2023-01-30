import 'package:date_ranger/date_ranger.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../widget/appBarWidget.dart';

class CalendarScreen extends StatelessWidget {
  CalendarScreen({Key? key}) : super(key: key);

  final initialDate = DateTime.now().obs;
  final initialDateRange = DateTimeRange(
      start: DateTime.now(), end: DateTime.now()).obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: CustomAppBar(
          leading: IconButton(onPressed: (){
            Get.back();
          }, icon: Icon(Icons.arrow_back_ios_outlined, color: AppTheme.darkColor,),),
          title: 'Calendrier',
        ),
        body: Stack(
          children: [
            Container(
              width: Get.width,
              padding: EdgeInsets.all(20),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 10),
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
                ],
              ),
            )
          ],
        ),
      );
    });
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
                          offset: Offset(0, 2),
                          blurRadius: 2,
                        ),
                      ]
                  )
              ),
              SizedBox(width: 10,),
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
            initialSelectedRange: PickerDateRange(initialDate.value, initialDate.value),
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
            initialSelectedRange: PickerDateRange(initialDate.value, initialDate.value),
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
