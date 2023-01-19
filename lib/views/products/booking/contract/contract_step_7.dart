import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/contract_controller/contract_controller.dart';
import 'package:gando/controllers/home/tabs/tab_controller.dart';
import 'package:gando/views/bottom_navigation_bar.dart';
import 'package:gando/views/home/home.dart';
import 'package:gando/views/products/booking/success_booking_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

class ContractStep7 extends StatelessWidget {
  ContractStep7({Key? key}) : super(key: key);

  final c = Get.put(ContractController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.backgroundColor,
        automaticallyImplyLeading: false,
        title: _buildBodyButtons(context),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          children: [
            SizedBox(
              width: Get.width,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Signatures',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppTheme.darkColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Divider(
              height: 10,
              color: AppTheme.darkColor,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width,
                  child: Text(
                    'En signant, vous acceptez que les informations que vous nous aviez citées dans le contrat sont exactes.',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: AppTheme.darkColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildBody(),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyButtons(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(29)),
            // splashColor: const Color(0xFFEEEEEE),
            onTap: () {
              //open bottom sheet
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Icon(
                Icons.arrow_back_rounded,
                color: AppTheme.darkColor,
              ),
            ),
          ),
          Container(
            height: 48,
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: Get.width / 2.2,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(29)),
              color: AppTheme.primaryColor,
            ),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(29)),
              // splashColor: const Color(0xFFEEEEEE),
              onTap: () {
                //open bottom sheet
                WidgetsBinding.instance.addPostFrameCallback((t) {
                  // Provider.of<TabScreenController>(context, listen: false)
                  //     .dispose();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SuccessBookingScreen()), (route) => true);
                });
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
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Signature du propriétaire',
              style: Theme.of(Get.context!).textTheme.bodyText2!.copyWith(
                    color: AppTheme.darkColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
              textAlign: TextAlign.left,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Signature(
                key: Get.keys[0],
                width: 300,
                height: 200,
                backgroundColor: AppTheme.light,
                controller: c.signature1.value,
              ),
            ),
            Text(
              'Signature du propriétaire',
              style: Theme.of(Get.context!).textTheme.bodyText2!.copyWith(
                    color: AppTheme.darkColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
              textAlign: TextAlign.left,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Signature(
                key: Get.keys[0],
                width: 300,
                height: 200,
                backgroundColor: AppTheme.light,
                controller: c.signature2.value,
              ),
            ),
          ],
        ),
      );
    });
  }

  void onPointerValueChanged(double value) {
    c.annotationValue.value = '${value.toInt()}';
  }
}
