import 'package:flutter/rendering.dart';
import 'package:gando/config/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:gando/views/products/available/widget/car_list_item.dart';
import 'package:get/get.dart';

import '../../../config/constants.dart';

class AvailableCarScreen extends StatelessWidget {
  const AvailableCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: buildAppBar(),
      body: SizedBox(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text('Choisissez votre véhicule', style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              overflow: TextOverflow.ellipsis,
              color: AppTheme.secondaryColor
            ),),
            SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: carList.length,
                itemBuilder: (context, index) => CarListItem(index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.primaryColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: const Text('Voiture disponible'),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {},
        )
      ],
    );
  }
}

