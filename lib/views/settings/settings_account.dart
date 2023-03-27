import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/constants.dart';
import 'package:gando/controllers/settings_controller/account_setting_controller.dart';
import 'package:gando/services/auth/auth_services.dart';
import 'package:gando/views/home/home.dart';
import 'package:gando/widget/appBarWidget.dart';
import 'package:gando/widget/submit_with_loading_button.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../../widget/customTextFormField.dart';

class SettingsAccountScreen extends GetView<AccountSettingController> {
  SettingsAccountScreen({Key? key}) : super(key: key);

  final _formKeyMail = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();
  final _formKeyDelete = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
        title: 'Paramètre du compte',
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Divider(
              color: AppTheme.darkColor,
            ),
            _createListMenu('Changer d\'email', context),
            Form(
              key: _formKeyMail,
              child: Column(
                children: _buildBodyTextField(context),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            _createListMenu('Modifier mon mot de passe', context),
            SizedBox(
              height: 5,
            ),
            Form(
              key: _formKeyPassword,
              child: Column(
                children: _buildPasswordChange(context),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            _createListMenu('Supprimer mon compte', context),
            Form(
              key: _formKeyDelete,
              child: Column(
                children: _buildDeleteAccount(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createListMenu(String menuTitle, context) {
    return Container(
      width: Get.width / 2,
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: Text(menuTitle,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      overflow: TextOverflow.visible,
                      color: AppTheme.darkColor.withOpacity(0.7),
                    )),
          ),
          Container(
              width: Get.width / 4,
              child: Divider(
                indent: 2,
                thickness: 2,
                height: 20,
                color: AppTheme.darkColor.withOpacity(0.2),
              ))
          // Icon(Icons.chevron_right, size: 20, color: AppTheme.secondaryColor),
        ],
      ),
    );
  }

  List<Widget> _buildBodyTextField(BuildContext context) => [
        CustomTextFormField(
          controller: controller.newEmailController.value,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Nouvel email is Required";
            } else if (!value.isEmail) {
              return "Email invalide";
            }
          },
          formatter: [],
          onChanged: (v) {},
          onSaved: (v) {},
          hintText: 'Nouvel email',
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          controller: controller.passwordControllerMail.value,
          obscureText: true,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Mot de passe is Required";
            }
          },
          formatter: [],
          onChanged: (v) {},
          onSaved: (v) {},
          hintText: 'Mot de passe',
        ),
        const SizedBox(height: 20),
        SubmitWithLoadingButton(
          text: 'Enregistrer'.toUpperCase(),
          onPressed: () {
            if (_formKeyMail.currentState!.validate()) {
              Get.focusScope!.unfocus();
              controller.initEditMailUser();
            }
          },
          isLoading: controller.isLoadingInitEditMailUser.value,
        ),
      ];

  List<Widget> _buildPasswordChange(BuildContext context) => [
        CustomTextFormField(
          controller: controller.currentPasswordController.value,
          obscureText: true,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Ancien mot de passe is Required";
            }
          },
          formatter: [],
          onChanged: (v) {},
          onSaved: (v) {},
          hintText: 'Ancien mot de passe',
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          controller: controller.passwordController.value,
          obscureText: true,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Nouveau mot de passe is Required";
            }
          },
          formatter: [],
          onChanged: (v) {},
          onSaved: (v) {},
          hintText: 'Nouveau mot de passe',
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          controller: controller.passwordConfirmController.value,
          keyboardType: TextInputType.text,
          obscureText: true,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Confirmer mot de passe is Required";
            } else if (value != controller.passwordController.value.text) {
              return 'Les mots de passe ne correspondent pas';
            }
          },
          formatter: [],
          onChanged: (v) {},
          onSaved: (v) {},
          hintText: 'Confirmer mot de passe',
        ),
        const SizedBox(height: 20),
        SubmitWithLoadingButton(
          text: 'Enregistrer'.toUpperCase(),
          onPressed: () async {
            if (_formKeyPassword.currentState!.validate()) {
              Get.focusScope!.unfocus();
              await controller.editPassword();
              if (controller.isSuccess.value) {
                Navigator.of(context).pop();
              }
            }
          },
          isLoading: controller.isLoadingEditPassword.value,
        ),
      ];

  List<Widget> _buildDeleteAccount(BuildContext context) => [
        CustomTextFormField(
          controller: controller.passwordControllerDelete.value,
          obscureText: true,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Mot de passe is Required";
            }
          },
          formatter: [],
          onChanged: (v) {},
          onSaved: (v) {},
          hintText: 'Mot de passe',
        ),
        const SizedBox(height: 20),
        SubmitWithLoadingButton(
          text: 'Supprimer'.toUpperCase(),
          onPressed: () async {
            if (_formKeyDelete.currentState!.validate()) {
              Get.focusScope!.unfocus();
              await Get.dialog(
                AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  backgroundColor: AppTheme.light,
                  title: Row(
                    children: [
                      Image.asset(
                        "${assetsImages}avertissement.png",
                        width: 30.0,
                      ),
                      SizedBox(width: 25.0),
                      Expanded(
                        child: Text(
                          "Avertissement",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppTheme.redColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  content: Text(
                    "Voulez-vous vraiment supprimer votre compte ?",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppTheme.darkColor,
                        ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "Non",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        Get.back();
                        await controller.deleteUser();
                        if (controller.isSuccess.value) {
                          Get.find<AuthService>().logout();
                        }
                      },
                      child: Text(
                        "Oui",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppTheme.redColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                      ),
                    )
                  ],
                ),
              );
            }
          },
          isLoading: controller.isLoadingDeleteUser.value,
          isDeleted: true,
        ),
      ];
}
