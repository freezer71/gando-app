import 'package:csc_picker/csc_picker.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/settings_controller/account_setting_controller.dart';
import 'package:gando/generated/assets.dart';
import 'package:gando/views/home/home.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../../../widget/appBarWidget.dart';
import '../../../widget/customTextFormField.dart';

class SocialNetworkScreen extends StatelessWidget {
  SocialNetworkScreen({Key? key}) : super(key: key);

  final c = Get.put(AccountSettingController());

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
          title: 'Mes réseaux sociaux',
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ..._buildBodyTextField(context),
          ],
        ),
      );
    });
  }

  List<Widget> _buildBodyTextField(BuildContext context) => [
        Container(
          width: Get.width - 40,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppTheme.redColor),
                child: Icon(Icons.facebook),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                width: Get.width / 1.5,
                child: CustomTextFormField(
                  controller: c.socialFacebook.value,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  validator: (v) {
                    return null;
                  },
                  onChanged: (v) {},
                  onSaved: (v) {},
                  hintText: 'Votre Facebook',
                  formatter: [],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: Get.width - 40,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppTheme.redColor),
                child: Image.asset(
                  Assets.imagesImg7,
                  scale: 2,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                width: Get.width / 1.5,
                child: CustomTextFormField(
                  controller: c.socialInstagram.value,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  validator: (v) {
                    return null;
                  },
                  onChanged: (v) {},
                  onSaved: (v) {},
                  hintText: 'Votre Instagram',
                  formatter: [],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: Get.width - 40,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppTheme.redColor),
                child: Image.asset(
                  Assets.imagesImg6,
                  scale: 2,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                width: Get.width / 1.5,
                child: CustomTextFormField(
                  controller: c.socialTwitter.value,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  validator: (v) {
                    return null;
                  },
                  onChanged: (v) {},
                  onSaved: (v) {},
                  hintText: 'Votre Twitter',
                  formatter: [],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: Get.width - 40,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppTheme.redColor),
                child: Image.asset(
                  Assets.imagesImg5,
                  scale: 2,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                width: Get.width / 1.5,
                child: CustomTextFormField(
                  controller: c.socialLinkedin.value,
                  keyboardType: TextInputType.phone,
                  autofocus: false,
                  validator: (v) {
                    return null;
                  },
                  onChanged: (v) {},
                  onSaved: (v) {},
                  hintText: 'Votre LinkedIn',
                  formatter: [],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        _buildBottomImage(),
      ];

  Widget _buildBottomImage() {
    return Image.asset(
      Assets.imagesImg4,
      scale: 3,
    );
  }
}
