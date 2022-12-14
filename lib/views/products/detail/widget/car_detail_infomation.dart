
import 'package:flutter/material.dart';
import 'package:gando/config/constants.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/models/car.dart';
import 'package:gando/widget/attribute.dart';
import 'package:get/get.dart';

class CarDetailInfomation extends StatelessWidget {
  const CarDetailInfomation({
    Key? key,
    required this.car,
  }) : super(key: key);

  final Car car;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
          color: AppTheme.primaryColor, borderRadius: BorderRadius.circular(16)),
      child: CarInfo(car: car),
    );
  }
}

class DriverCall extends StatelessWidget {
  const DriverCall({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {},
          // color: mCardColor,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(36),
          // ),
          child: Text(
            'Call',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          // color: mCardColor,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(36),
          // ),
          child: Text(
            'Book Now',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}

class DiverAppraise extends StatelessWidget {
  const DiverAppraise({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const  [
         Text(
          '5.0',
          style: TextStyle(),
        ),
        SizedBox(
          width: 6,
        ),
        // RatingBar(
        //   onRatingUpdate: (value) {},
        //   size: 14,
        //   selectColor: Colors.white,
        // ),
      ],
    );
  }
}

class DriverInfo extends StatelessWidget {
  const DriverInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jesica Smith',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'License NWR 369852',
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              '369',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Ride',
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class CarInfo extends StatelessWidget {
  const CarInfo({
    Key? key,
    required this.car,
  }) : super(key: key);

  final Car car;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${car.price} €',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            const Text(
              'euro/hr',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(width: Get.width/5.2,),
            Row(
              children: [
                Text('4.5'),
                Container(child: Icon(Icons.star, color: Colors.amber,),),
                Container(child: Icon(Icons.star, color: Colors.amber,),),
                Container(child: Icon(Icons.star, color: Colors.amber,),),
                Container(child: Icon(Icons.star, color: Colors.amber,),),
                Container(child: Icon(Icons.star_half, color: Colors.amber),),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          width: Get.width / 1.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Column(
                children: const [
                  Icon(Icons.location_searching_rounded),
                  Text('500 m')
                ],
              ),
              Attribute(
                value: car.brand,
                name: 'Marque',
                textColor: AppTheme.backgroundColor,
              ),
              Attribute(
                value: car.fuelCons,
                name: 'Conso.',
                textColor: AppTheme.backgroundColor,
              ),
            ],
          ),
        )
      ],
    );
  }
}
