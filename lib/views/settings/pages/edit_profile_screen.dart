import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/constants.dart';
import 'package:gando/controllers/user/edit_profile_controller.dart';
import 'package:gando/widget/customTextFormField.dart';
import 'package:gando/widget/submit_with_loading_button.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widget/appBarWidget.dart';

class EditProfileScreen extends GetView<EditProfilController> {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: CustomAppBar(
        leading: IconButton(
          onPressed: () {
            Get.back(result: controller.user.value);
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: AppTheme.darkColor,
          ),
        ),
        title: 'Modifier mon profil',
      ),
      body: Obx(
        () => ListView(
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: "${controller.user.value.photo}",
                        errorWidget: (context, url, error) =>
                            Image.asset("$assetsImages/defaultImage.png"),
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
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          final XFile? image = await showDialog<XFile?>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) => SimpleDialog(
                              backgroundColor:
                                  Colors.transparent.withOpacity(0.05),
                              insetPadding:
                                  EdgeInsets.only(top: Get.width / 0.8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Colors.white),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        onTap: () async {
                                          // Pick an image
                                          final XFile? image =
                                              await _picker.pickImage(
                                            source: ImageSource.gallery,
                                            imageQuality: 50,
                                          );
                                          Get.back(result: image);
                                        },
                                        title: Text(
                                          textAlign: TextAlign.center,
                                          "Importer une photo",
                                          style: TextStyle(
                                              color: AppTheme.darkColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Divider(
                                          thickness: 1.0,
                                          color: AppTheme.darkColor),
                                      ListTile(
                                        onTap: () async {
                                          // capture an image
                                          final XFile? image =
                                              await _picker.pickImage(
                                            source: ImageSource.camera,
                                            imageQuality: 50,
                                          );
                                          Get.back(result: image);
                                        },
                                        title: Text(
                                          textAlign: TextAlign.center,
                                          "Prendre une photo",
                                          style: TextStyle(
                                              color: AppTheme.darkColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                /*Divider(
                                    thickness: 1.0, color: AppTheme.darkColor),*/
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Colors.white),
                                  child: ListTile(
                                    onTap: () async {
                                      Get.back();
                                    },
                                    title: Text(
                                      textAlign: TextAlign.center,
                                      "Annuler",
                                      style: TextStyle(
                                          color: AppTheme.darkColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                          if (image != null) {
                            final file = File(image.path);
                            controller.uploadProfilePicture(file: file);
                          }
                        },
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )),
                        ),
                        child: Container(
                          height: 20,
                          width: Get.width / 1.5,
                          child: Center(
                            child: Text(
                              'Changer la photo de profil',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2.0,
                                    color: AppTheme.darkColor,
                                  ),
                            ),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: TextFormField(
                      onChanged: (value) {
                        controller.numberTextDescription.value = value.length;
                      },
                      maxLength: 255,
                      controller: controller.descriptionController.value,
                      maxLines: 7,
                      style: TextStyle(color: AppTheme.darkColor),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        filled: true,
                        fillColor: AppTheme.light,
                        labelStyle:
                            Theme.of(context).textTheme.bodyText2!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  overflow: TextOverflow.visible,
                                  color: AppTheme.darkColor.withOpacity(0.5),
                                ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                          "${controller.numberTextDescription.value} / 255",
                          style: TextStyle(color: AppTheme.darkColor)),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SubmitWithLoadingButton(
                    text: 'Enregistrer',
                    onPressed: () async {
                      await controller.editNameAndDescription();
                      if (controller.isSuccess.value) {
                        Navigator.of(context).pop();
                      }
                    },
                    isLoading: controller.isLoading.value,
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
          controller: controller.firstNameController.value,
          keyboardType: TextInputType.text,
          enabled: true,
          formatter: [],
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Nom is Required";
            }
          },
          hintText: "",
          onChanged: (String) {},
          onSaved: (String) {},
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          controller: controller.lastNameController.value,
          keyboardType: TextInputType.text,
          enabled: true,
          formatter: [],
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Prénom is Required";
            }
          },
          hintText: "",
          onChanged: (String) {},
          onSaved: (String) {},
        ),
      ];
}
