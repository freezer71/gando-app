
import 'package:flutter/material.dart';
import 'package:gando/config/constants.dart';
import 'package:gando/models/car.dart';
import 'package:gando/views/products/detail/car_detail_screen.dart';
import 'package:gando/views/products/detail/components/car_detail.dart';
import 'package:gando/views/products/detail/widget/car_detail_infomation.dart';

class HomeCardCar extends StatelessWidget {
  final int index;
  const HomeCardCar(this.index, {Key? key}) : super(key: key);

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
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Stack(
          children: [
            CarDetailInfomation(car: car),
            Positioned(
              right: 10,
              top: 10,
              child: Image.asset(
                car.image,
                height: 90,
              ),
            )
          ],
        ),
      ),
    );
  }
}