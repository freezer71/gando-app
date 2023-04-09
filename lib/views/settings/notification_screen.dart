import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/settings_controller/account_setting_controller.dart';
import 'package:gando/views/home/home.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../widget/appBarWidget.dart';

class NotificationScreen extends GetView<AccountSettingController> {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          appBar: CustomAppBar(
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: AppTheme.darkColor,
              ),
            ),
            title: 'Notifications',
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 15.0),
            child: Row(
              children: [
                Flexible(
                  flex: 4,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5.0,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.titleNotificationList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.titleNotificationList[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 14,
                                              overflow: TextOverflow.ellipsis,
                                              color: AppTheme.darkColor)),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('App',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                  color: AppTheme.darkColor)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ListView.builder(
                            itemCount: controller.listCheckBoxApp.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Checkbox(
                                fillColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) =>
                                      states.contains(MaterialState.disabled)
                                          ? AppTheme.secondaryColor
                                          : AppTheme.primaryColor,
                                ),
                                checkColor: AppTheme.secondaryColor,
                                value: controller.listCheckBoxApp[index],
                                onChanged: (value) {
                                  controller.updateListCheckboxApp(
                                      value: value!, index: index);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    children: [
                      Text('Email',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                  color: AppTheme.darkColor)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ListView.builder(
                            itemCount: controller.listCheckBoxEmail.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Checkbox(
                                fillColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) =>
                                      states.contains(MaterialState.disabled)
                                          ? AppTheme.secondaryColor
                                          : AppTheme.primaryColor,
                                ),
                                checkColor: AppTheme.secondaryColor,
                                value: controller.listCheckBoxEmail[index],
                                onChanged: (value) {
                                  controller.updateListCheckboxEmail(
                                      value: value!, index: index);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
