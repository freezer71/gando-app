import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/generated/assets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'contract_step_2.dart';

class ContractStep1 extends StatelessWidget {
  const ContractStep1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.backgroundColor,
        automaticallyImplyLeading: false,
        title: _buildBodyButtons(),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 80, horizontal: 5),
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: Get.height / 5,),
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [
                        AppTheme.primaryColor,
                        AppTheme.redColor,
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.5, 0.0],),
                  
                ),
                child: LottieBuilder.asset(Assets.zip57028Contrato),
              ),
            ),
            SizedBox(height: 40,),
            Text('Contrat de location', style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: AppTheme.darkColor,
                fontSize: 22,
                fontWeight: FontWeight.w900))
          ],
        ),
      ),
    );
  }

  Widget _buildBodyButtons() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: Get.width / 2.3,
            height: 48,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(29)),
              color: AppTheme.light,

            ),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(29)),
              // splashColor: const Color(0xFFEEEEEE),
              onTap: () => Get.back(),
              child: Center(
                child: Text(
                  'Annuler'.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppTheme.redColor,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 48,
            margin: EdgeInsets.symmetric(vertical: 10),
            width: Get.width / 2.3,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(29)),
              color: AppTheme.primaryColor,

            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(29)),
                // splashColor: const Color(0xFFEEEEEE),
                onTap: () {
                  //open bottom sheet
                  Get.to(() => ContractStep2());
                },
                child: Center(
                  child: Text(
                    'Suivant'.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppTheme.light,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
