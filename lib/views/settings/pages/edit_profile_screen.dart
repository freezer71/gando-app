import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/settings_controller/account_setting_controller.dart';
import 'package:gando/models/ProfileSeller.dart';
import 'package:gando/widget/customTextFormField.dart';
import 'package:get/get.dart';

import '../../../widget/appBarWidget.dart';
import '../../home/home.dart';

class EditProfileScreen extends StatelessWidget {
  final ProfileSeller seller;

  EditProfileScreen({Key? key, required this.seller}) : super(key: key);

  final c  = Get.put(AccountSettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: CustomAppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios_outlined, color: AppTheme.darkColor,),),
        title: 'Modifier mon profil',
      ),
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CircleAvatar(
                      backgroundColor: AppTheme.backgroundColor,
                      backgroundImage: AssetImage(
                        seller.image,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => Get.back(),
                        style: ButtonStyle(
                          overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )),
                        ),
                        child: Container(
                          height: 20,
                          width: Get.width / 1.5,
                          child: Center(
                            child: Text('Changer la photo de profil', style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              color: AppTheme.darkColor,
                            ),),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        ..._buildTextField(context),
                      ],
                    ),
                  ),
                  Divider(
                    height: 40,
                    color: AppTheme.darkColor,
                  ),
                  Container(
                    height: Get.height / 4,
                    width: Get.width - 50,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: AppTheme.light,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text(seller.description,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                  color: AppTheme.darkColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextButton(
                    onPressed: () => Get.back(),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) =>
                         AppTheme.primaryColor,
                      ),
                      overlayColor:
                      MaterialStateProperty.all(Colors.transparent),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                    ),
                    child: Container(
                      height: 30,
                      width: Get.width / 1.5,
                      child: Center(
                        child: Text('Valider'.toUpperCase(), style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: AppTheme.light,
                        ),),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTextField(BuildContext context) => [
    CustomTextFormField(
      controller: c.nameController.value,
      keyboardType: TextInputType.text,
      enabled: true,
      formatter: [],
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "Nom is Required";
        }
      }, hintText: 'Nom', onChanged: (String) {  }, onSaved: (String) {  },
    ),
    const SizedBox(height: 20),
    CustomTextFormField(
      controller: c.firstnameController.value,
      keyboardType: TextInputType.text,
      enabled: true,
      formatter: [],
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "Prénom is Required";
        }
      }, hintText: 'Prénom', onChanged: (String) {  }, onSaved: (String) {  },
    ),
  ];

}
