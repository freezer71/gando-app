import 'package:flutter/material.dart';
import 'package:gando/config/constants.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/helpers/global_function.dart';
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
      width: 320,
      height: 200,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
          color: AppTheme.light,
          boxShadow: [
            BoxShadow(
                color: AppTheme.darkColor.withOpacity(0.11),
                offset: const Offset(0.0, 1.2),
                blurRadius: 6.0,
                spreadRadius: 3,
                blurStyle: BlurStyle.normal),
          ],
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: AssetImage(car.image, ), alignment: Alignment.center, repeat: ImageRepeat.noRepeat, fit: BoxFit.cover, )),
      child: NextCarInfo(car: car),
    ).paddingZero;
  }
}

class NextCarInfo extends StatelessWidget {
  NextCarInfo({
    Key? key,
    required this.car,
  }) : super(key: key);

  final gf = GlobalFunction();
  final Car car;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            // Container(
            //   height: 120,
            //   padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            //   decoration: BoxDecoration(
            //     borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            //       image: DecorationImage(image: AssetImage(car.image,), alignment: Alignment.center, repeat: ImageRepeat.noRepeat, fit: BoxFit.cover)),
            // ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                      color: AppTheme.primaryColor,
                    ),
                    child: Icon(
                      Icons.star,
                      color: AppTheme.light,
                    ),
                  ).marginZero.paddingZero,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5.5),
                    decoration: BoxDecoration(
                      color: AppTheme.light,
                      boxShadow: [
                        BoxShadow(color: AppTheme.darkColor, blurRadius: 0.1),
                      ],
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                    ),
                    child: Text('4.5/5', style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppTheme.darkColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                  ).marginZero
                ],
              ),
            )
          ],
        ),
        Container(
          height: 70,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
            color: AppTheme.darkColor,
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('${car.brand} ${car.model}', style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppTheme.light,
                      fontSize: 18,
                      fontWeight: FontWeight.w900)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on_rounded, size: 20,),
                      Text('Localisation', style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: AppTheme.light,
                          fontSize: 14,
                          fontWeight: FontWeight.w300)),
                    ],
                  )
                ],
              ),
              Container(child: Text('${gf.removeDecimalZeroFormat(car.price.toDouble())}', style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppTheme.primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),)
            ],
          ),
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
            SizedBox(
              width: Get.width / 5.4,
            ),
            Row(
              children: [
                const Text('4.5'),
                Container(
                  child: const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
                Container(
                  child: const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
                Container(
                  child: const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
                Container(
                  child: const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
                Container(
                  child: const Icon(Icons.star_half, color: Colors.amber),
                ),
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
            children: [
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

// class DriverCall extends StatelessWidget {
//   const DriverCall({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         TextButton(
//           onPressed: () {},
//           // color: mCardColor,
//           // shape: RoundedRectangleBorder(
//           //   borderRadius: BorderRadius.circular(36),
//           // ),
//           child: const Text(
//             'Call',
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ),
//         ),
//         TextButton(
//           onPressed: () {},
//           // color: mCardColor,
//           // shape: RoundedRectangleBorder(
//           //   borderRadius: BorderRadius.circular(36),
//           // ),
//           child: const Text(
//             'Book Now',
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
//
// class DiverAppraise extends StatelessWidget {
//   const DiverAppraise({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: const  [
//          Text(
//           '5.0',
//           style: TextStyle(),
//         ),
//         SizedBox(
//           width: 6,
//         ),
//         // RatingBar(
//         //   onRatingUpdate: (value) {},
//         //   size: 14,
//         //   selectColor: Colors.white,
//         // ),
//       ],
//     );
//   }
// }
//
// class DriverInfo extends StatelessWidget {
//   const DriverInfo({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text(
//               'Jesica Smith',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             Text(
//               'License NWR 369852',
//               style: TextStyle(
//                 fontSize: 10,
//               ),
//             ),
//           ],
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: const [
//             Text(
//               '369',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.white,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             Text(
//               'Ride',
//               style: TextStyle(
//                 fontSize: 10,
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }
