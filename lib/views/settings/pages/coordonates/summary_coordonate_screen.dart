import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/widget/appBarWidget.dart';
import 'package:get/get.dart';
import 'package:gando/views/settings/pages/coordonates/home_coordonates_screen.dart';

class SummaryCoordonateView extends StatelessWidget {
  const SummaryCoordonateView({Key? key}) : super(key: key);

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
        title: 'Mes coordonnées',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Civilité",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppTheme.darkColor,
                        fontSize: 16,
                      )),
              const SizedBox(
                height: 10,
              ),
              Text("Monsieur",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              Text("Numéro de téléphone",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppTheme.darkColor,
                        fontSize: 16,
                      )),
              const SizedBox(
                height: 10,
              ),
              Text("08.00.00.00.00",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              Text("Date de naissance",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppTheme.darkColor,
                        fontSize: 16,
                      )),
              const SizedBox(
                height: 10,
              ),
              Text("24/02/2000",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              Text("Lieu de naissance",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppTheme.darkColor,
                        fontSize: 16,
                      )),
              const SizedBox(
                height: 10,
              ),
              Text("Paris",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              Text("Adresse",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppTheme.darkColor,
                        fontSize: 16,
                      )),
              const SizedBox(
                height: 10,
              ),
              Text("1 Rue Alfred Nobel",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              Text("Complément d'adresse",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppTheme.darkColor,
                        fontSize: 16,
                      )),
              const SizedBox(
                height: 10,
              ),
              Text("N/A",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              Text("Pays",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppTheme.darkColor,
                        fontSize: 16,
                      )),
              const SizedBox(
                height: 10,
              ),
              Text("France",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppTheme.darkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Code Postal ",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: AppTheme.darkColor,
                                    fontSize: 16,
                                  )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("75000",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  color: AppTheme.darkColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 50.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ville",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: AppTheme.darkColor,
                                    fontSize: 16,
                                  )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("Paris",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  color: AppTheme.darkColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 25.0,
              ),
              TextButton(
                onPressed: () => Get.to(() => HomeCordonatesView()),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    return AppTheme.primaryColor;
                  }),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  )),
                ),
                child: Container(
                  height: 40,
                  width: Get.width / 1.3,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Center(
                    child: Text(
                      'Mettre à jour mon profil'.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: AppTheme.backgroundColor,
                          ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
