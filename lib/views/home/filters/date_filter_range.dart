import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:get/get.dart';

class DateFilterRange extends StatelessWidget {
  DateFilterRange({Key? key}) : super(key: key);

  DateTime? chosenDateTime;

  //android datepicker
  androidDatePicker(BuildContext context) async {
    chosenDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    print(chosenDateTime);
  }

  //ios date picker
  iosDatePicker(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.25,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (value) {
                chosenDateTime = value;
                print(chosenDateTime);
              },
              initialDateTime: DateTime.now(),
              minimumYear: 2000,
              maximumYear: 3000,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 2,
      child: Container(
        height: 380,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: AppTheme.backgroundColor,
        ),
        child: Column(
          children: [
            Container(
              color: Colors.transparent,
              height: Get.height / 12,
              margin: EdgeInsets.symmetric(vertical: 15),
              child: TabBar(
                overlayColor: MaterialStateProperty.all(Colors.red),
                automaticIndicatorColorAdjustment: false,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppTheme.redColor,
                indicatorWeight: 2.0,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppTheme.redColor,
                ),
                tabs: [
                  Tab(
                    height: 30.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_month,
                            size: 25,
                            color: AppTheme.darkColor.withOpacity(0.9)),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Départ',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                    overflow: TextOverflow.ellipsis,
                                    color: AppTheme.darkColor,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_month,
                            size: 25,
                            color: AppTheme.darkColor.withOpacity(0.9)),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Retour',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                    overflow: TextOverflow.ellipsis,
                                    color: AppTheme.darkColor,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: Get.height ,
                color: AppTheme.backgroundColor,
                child: TabBarView(
                  children: [
                    CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (value) {
                        chosenDateTime = value;
                        print(chosenDateTime);
                      },
                      initialDateTime: DateTime.now(),
                      minimumYear: 2000,
                      maximumYear: 3000,
                    ),
                    CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.dateAndTime,
                      onDateTimeChanged: (value) {
                        chosenDateTime = value;
                        print(chosenDateTime);
                      },
                      initialDateTime: DateTime.now(),
                      minimumYear: 2000,
                      maximumYear: 3000,
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(18.0),
              child: TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 80)),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) => AppTheme.darkColor,
                    ),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => SearchPage()));
                  },
                  child: Text(
                    'Confirmer',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          color: AppTheme.backgroundColor,
                        ),
                  )),
            ),
          ],
        ),
      ));
}
