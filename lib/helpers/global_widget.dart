



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gando/config/textstyle.dart';

class GlobalWidget {
  static TextFormField CustomTextFormField(
      {
        Key? key,
        BuildContext? context,
        TextInputType? keyboardType,
        controller,
        String initialValue  = '',
        String hintText = '',
        String? Function(String?)? validator,
        List<TextInputFormatter>? formatter,
        void Function(String?)? onChanged,
        void Function(String?)? onSaved,
        Widget? suffixIcon,
        Widget? prefixIcon,
        bool obscureText = false,
        bool autofocus = false,
        bool enabled = true,
        double shape = 30.0,
      }) => TextFormField(
      key: key,
      controller: controller,

      // initialValue: initialValue!,
      obscureText: obscureText,
      keyboardType: keyboardType!, //TextInputType.emailAddress
      cursorColor: AppTheme.primaryColor,
      cursorRadius: const Radius.circular(50),
      cursorWidth: 3,
      style: Theme
          .of(context!)
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
        suffixIcon: suffixIcon,
        prefixIconColor: AppTheme.backgroundColor,
        prefixIcon: prefixIcon,
        enabled: enabled,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: AppTheme.darkColor,
          ),
          borderRadius: BorderRadius.circular(shape),
          gapPadding: 8.0,
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
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(shape),
            gapPadding: 8.0),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.redColor.withOpacity(0.4),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(shape),
            gapPadding: 8.0),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.darkColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(shape),
            gapPadding: 8.0),
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