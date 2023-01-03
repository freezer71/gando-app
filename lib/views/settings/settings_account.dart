import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/settings_controller/account_setting_controller.dart';
import 'package:gando/views/home/home.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../../widget/customTextFormField.dart';

class SettingsAccountScreen extends StatelessWidget {
  SettingsAccountScreen({Key? key}) : super(key: key);

  final c = Get.put(AccountSettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios_outlined, color: AppTheme.darkColor,),),
        title: Text(
          'Paramètre du compte',
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              overflow: TextOverflow.ellipsis,
              color: AppTheme.darkColor
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Divider(
            color: AppTheme.darkColor,
          ),
          _createListMenu('Changer d\'email', context),
          ..._buildBodyTextField(context),
          SizedBox(height: 30,),
          _createListMenu('Modifier mon mot de passe', context),
          SizedBox(height: 5,),
          ..._buildPasswordChange(context),
          SizedBox(height: 30,),
          _createListMenu('Supprimer mon compte', context),
          ..._buildDeleteAccount(context)
        ],
      ),
    );
  }

  Widget _createListMenu(String menuTitle, context) {
    return Container(
      width: Get.width/ 2,
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: Text(menuTitle, style: Theme
                .of(context)
                .textTheme
                .bodyText2!
                .copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              overflow: TextOverflow.visible,
              color: AppTheme.darkColor.withOpacity(0.7),
            )),
          ),
          Container( width: Get.width / 4, child: Divider(indent: 2, thickness: 2, height: 20,color: AppTheme.darkColor.withOpacity(0.2),))
          // Icon(Icons.chevron_right, size: 20, color: AppTheme.secondaryColor),
        ],
      ),
    );
  }

  List<Widget> _buildBodyTextField(BuildContext context) =>
      [
        CustomTextFormField(
          controller: c.oldEmailController.value,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Ancien email is Required";
            }
          }, formatter: [], onChanged: (v) {  }, onSaved: (v) {  }, hintText: 'Ancien email',
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          controller: c.newEmailController.value,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Nouvel email is Required";
            }
          }, formatter: [], onChanged: (v) {  }, onSaved: (v) {  }, hintText: 'Nouvel email',
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          controller: c.passwordController.value,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Mot de passe is Required";
            }
          }, formatter: [], onChanged: (v) {  }, onSaved: (v) {  }, hintText: 'Mot de passe',
        ),
        const SizedBox(height: 20),
        _buildSubmitButton(context, () {}, delete: false),
      ];

  List<Widget> _buildPasswordChange(BuildContext context) =>
      [
        CustomTextFormField(
          controller: c.passwordController.value,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Nouveau mot de passe is Required";
            }
          }, formatter: [], onChanged: (v) {  }, onSaved: (v) {  }, hintText: 'Nouveau mot de passe',
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          controller: c.passwordConfirmController.value,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Confirmer mot de passe is Required";
            }
          }, formatter: [], onChanged: (v) {  }, onSaved: (v) {  }, hintText: 'Confirmer mot de passe',
        ),
        const SizedBox(height: 20),
        _buildSubmitButton(context, () {}, delete: false),
      ];

  List<Widget> _buildDeleteAccount(BuildContext context) =>
      [
        CustomTextFormField(
          controller: c.passwordController.value,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Mot de passe is Required";
            }
          }, formatter: [], onChanged: (v) {  }, onSaved: (v) {  }, hintText: 'Mot de passe',
        ),
        const SizedBox(height: 20),
        _buildSubmitButton(context, () {}, delete: true),
      ];

  Widget _buildSubmitButton(BuildContext context, Callback func, {delete} ){
    return TextButton(
      onPressed: func,
      style: ButtonStyle(
        backgroundColor:
        MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) =>
          states.contains(MaterialState.disabled)
              ? AppTheme.primaryColor
              : delete! ? AppTheme.redColor : AppTheme.primaryColor,
        ),
        overlayColor:
        MaterialStateProperty.all(Colors.transparent),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            )),
      ),
      child: Container(
        height: 40,
        width: Get.width / 1.3,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Center(
          child: Text('Enregistrer', style: Theme.of(context).textTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 16,
            color: AppTheme.backgroundColor,
          ),),
        ),
      ),
    );
  }
}
