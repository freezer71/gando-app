import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/settings_controller/account_setting_controller.dart';
import 'package:gando/views/home/home.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);

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
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: AppTheme.darkColor,
          ),
        ),
        title: Text(
          'Notification'.toUpperCase(),
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              overflow: TextOverflow.ellipsis,
              color: AppTheme.darkColor),
        ),
      ),
      body: Obx(() {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Divider(
              color: AppTheme.darkColor,
            ),
            Container(
              width: Get.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 130,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('App',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis,
                                    color: AppTheme.darkColor)),
                        SizedBox(
                          width: 5,
                        ),
                        Text('SMS',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis,
                                    color: AppTheme.darkColor)),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Email',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis,
                                    color: AppTheme.darkColor)),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            _createListMenu('Demande de locations', [
              c.locationApp.value,
              c.locationSms.value,
              c.locationEmail.value,
            ]),
            _createListMenu('Confirmation de réservation', [
              c.bookingApp.value,
              c.bookingSms.value,
              c.bookingEmail.value,
            ]),
            _createListMenu('Messages', [
              c.messageApp.value,
            ]),
            _createListMenu('Annulation de réservation', [
              c.cancelBookingApp.value,
              c.cancelBookingSms.value,
            ]),
            _createListMenu('Contrat de location', [
              c.locationContractApp.value,
              c.locationContractSms.value,
              c.locationContractEmail.value,
            ]),
            _createListMenu('Paiement', [
              c.paymentApp.value,
              c.paymentEmail.value,
            ]),
          ],
        );
      }),
    );
  }

  Widget _createListMenu(String menuTitle, List box) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(width: Get.width / 2,
      child: Text(
        menuTitle,
        style: TextStyle(fontSize: 13, color: AppTheme.darkColor),
      ),
          ),
          Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
            box.length, (index) => _buildCheckbox(box[index])))
        ]),
    );
  }

  Widget _buildCheckbox(c) {
    return Checkbox(
        fillColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) => states.contains(MaterialState.disabled)
              ? AppTheme.secondaryColor
              : AppTheme.primaryColor,
        ),
        checkColor: AppTheme.secondaryColor,
        value: c,
        onChanged: (value) {
          c = !c;
        });
  }
}
