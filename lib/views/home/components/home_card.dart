
import 'package:flutter/material.dart';
import 'package:gando/config/constants.dart';
import 'package:gando/models/Car.dart';
import 'package:gando/views/products/detail/car_detail_screen.dart';
import 'package:gando/views/products/detail/components/car_detail.dart';
import 'package:gando/views/products/detail/widget/car_detail_infomation.dart';

class HomeCardCar extends StatelessWidget {
  final int index;
  final Car car;
  const HomeCardCar(this.index, this.car, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


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
      child: _buildNextHomeCardCar(context, car),
    );
  }

  Widget _buildNextHomeCardCar(BuildContext context, car) {
    return CarDetailInfomation(car: car);
  }

  Widget _buildOldHomeCardCar(BuildContext context, car) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Stack(
        children: [
          CarDetailInfomation(car: car),
          // Positioned(
          //   right: 10,
          //   top: 10,
          //   child: Image.asset(
          //     car.image,
          //     height: 90,
          //   ),
          // )
        ],
      ),
    );
  }
}
