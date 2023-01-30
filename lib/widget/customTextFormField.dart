

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/textstyle.dart';

class CustomTextFormField extends StatelessWidget {

  final BuildContext? context;
  final TextInputType? keyboardType;
  final controller;
  String? initialValue = '';
  String? hintText = '';
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? formatter;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSaved;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  bool obscureText;
  bool autofocus;
  bool enabled;
  double shape;

  CustomTextFormField({Key? key,
    this.context,
    required this.keyboardType,
    this.controller,
    required this.validator,
    required this.formatter,
    required this.onChanged,
    required this.onSaved,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.shape = 30.0,
    this.enabled = true,
    this.autofocus = false,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: controller,
      // initialValue: initialValue,
      obscureText: obscureText,
      keyboardType: keyboardType!, //TextInputType.emailAddress
      cursorColor: AppTheme.primaryColor,
      cursorRadius: const Radius.circular(50),
      cursorWidth: 3,
      style: Theme
          .of(context)
          .textTheme
          .bodyText2!
          .copyWith(
        fontWeight: FontWeight.w900,
        fontSize: 18,
        overflow: TextOverflow.ellipsis,
        color: HexColor(AppTheme.primaryColorString!),
      ),
      enabled: enabled,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppTheme.light,
        // suffixIcon: suffixIcon,/**/
        suffix: suffixIcon,
        prefixIconColor: AppTheme.backgroundColor,
        prefixIcon: prefixIcon,
        enabled: enabled,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.5,
            color: AppTheme.darkColor,
          ),
          borderRadius: BorderRadius.circular(shape),
          gapPadding: 4.0,
        ),
        hintText: hintText,
        labelStyle: Theme
            .of(context)
            .textTheme
            .bodyText2!
            .copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          overflow: TextOverflow.ellipsis,
          color: HexColor(AppTheme.primaryColorString!),
        ),
        hintStyle: Theme
            .of(context)
            .textTheme
            .bodyText2!
            .copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          overflow: TextOverflow.ellipsis,
          color: AppTheme.darkColor,
        ),
        errorMaxLines: 1,
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.darkColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(shape),
            gapPadding: 4.0),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.redColor.withOpacity(0.4),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(shape),
            gapPadding: 4.0),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.darkColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(shape),
            gapPadding: 1.0),
      ),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: autofocus,
      inputFormatters: formatter!,
      // default
      onSaved: onSaved!,
      // default null
      onChanged: onChanged!, // default null
      // ... + other textfield params
    );
  }
}
