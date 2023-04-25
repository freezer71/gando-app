import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/generated/assets.dart';
import 'package:gando/views/home/home.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back, color: AppTheme.darkColor)),
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.credit_card,
                color: AppTheme.darkColor,
              ),
              const SizedBox(width: 10),
              Text(
                'Carte bancaire',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: AppTheme.darkColor,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: 100,
              height: 100,
              child: Lottie.asset(
                Assets.lottiesSuccess,
              )),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Félicitations !',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppTheme.darkColor,
                        fontSize: 36,
                        fontWeight: FontWeight.w900)),
                const SizedBox(
                  height: 20,
                ),
                Text('Votre demande location est désormais en attente',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppTheme.darkColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w700)),
                const SizedBox(
                  height: 20,
                ),
                Text(
                    'Une notifications sera envoyé au propriétaire Marco DEGARDIO.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppTheme.darkColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(HomeScreen());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.darkColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  height: Get.height / 10,
                  width: Get.width / 3,
                  child: Icon(
                    Icons.thumb_up_alt_rounded,
                    size: 50,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Text('Retour à l\'accueil',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppTheme.redColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
