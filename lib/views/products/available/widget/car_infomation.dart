
import 'package:flutter/material.dart';
import 'package:gando/config/constants.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/models/Car.dart';
import 'package:gando/widget/attribute.dart';

class CarInfomation extends StatelessWidget {
  const CarInfomation({
    Key? key,
    required this.car,
  }) : super(key: key);

  final Car car;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 24, right: 24,top: 50),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${car.price}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'euro/hr',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Attribute(
                value: car.brand,
                name: 'Marque',
              ),
              Attribute(
                value: car.model,
                name: 'Model',
              ),
              Attribute(
                value: car.co2,
                name: 'CO2',
              ),
              Attribute(
                value: car.fuelCons,
                name: 'Conso.',
              ),
            ],
          )
        ],
      ),
    );
  }
}

