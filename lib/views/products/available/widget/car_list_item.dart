
import 'package:flutter/material.dart';
import 'package:gando/config/constants.dart';
import 'package:gando/models/Car.dart';
import 'package:gando/views/products/available/widget/car_infomation.dart';
import 'package:gando/views/products/detail/car_detail_screen.dart';
import 'package:gando/views/products/detail/components/car_detail.dart';

class CarListItem extends StatelessWidget {
  const CarListItem(
    this.index, {
    Key? key,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    Car car = carList[index];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CarDetailPage(car: car);
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Stack(
          children: [
            CarInfomation(car: car),
            Positioned(
              right: 40,
              child: Image.asset(
                car.images!.avant34!,
                height: 100,
              ),
            )
          ],
        ),
      ),
    );
  }
}
