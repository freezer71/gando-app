// create generique submit button with loading

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../config/textstyle.dart';

class SubmitWithLoadingButton extends StatelessWidget {
  const SubmitWithLoadingButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.width,
    this.height,
    this.fontSize,
    this.isDeleted = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final bool isLoading;
  final double? width;
  final double? height;
  final bool? isDeleted;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return buildButton(context: context, width: width);
  }

  Widget buildButton({required BuildContext context, double? width}) {
    return TextButton(
      onPressed: () {
        if (isLoading == false) {
          onPressed();
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) => isLoading
              ? isDeleted == true
                  ? AppTheme.redColor.withOpacity(0.5)
                  : AppTheme.primaryColor.withOpacity(0.5)
              : isDeleted == true
                  ? AppTheme.redColor
                  : AppTheme.primaryColor,
        ),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        )),
      ),
      child: Container(
        height: height ?? 40,
        width: width ?? Get.width / 1.3,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Center(
            child: !isLoading
                ? Text(
                    text,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: fontSize ?? 16,
                          color: AppTheme.backgroundColor,
                        ),
                  )
                : const CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
