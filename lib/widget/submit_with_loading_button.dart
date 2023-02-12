

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
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return buildButton(context);
  }

  Widget buildButton (BuildContext context) {
    return isLoading
        ? const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
      ),
    ) : TextButton(
      onPressed: onPressed,

      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) =>  AppTheme.primaryColor
        ),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      child: Container(
        height: 40,
        width: Get.width / 1.3,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Center(
          child: Text(
            text.toUpperCase(),
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: AppTheme.backgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}