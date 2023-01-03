import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../models/car.dart';

const String API_CURRENCY_URL = 'https://v6.exchangerate-api.com/v6/fb9a92f621ca5c72e9f3cb7a/latest/';
const int STATUS_OK = 200;

const Color mPrimaryColor = Color(0xFF40ac9c);

const Color mCardColor = Color(0xFF203e5a);

List<Car> carList = [
  Car('assets/images/bentley.png', 120, 'Bentley', '3A 9200', '77/km', '5,5 L', LatLng(16.2613042,-61.5302309),),
  Car('assets/images/rolls_royce.png', 185, 'RR', '3A 9200', '77/km', '5,5 L', LatLng(16.2613042,-61.5533309),),
  Car('assets/images/maserati.png', 100, 'Maserati', '3A 9200', '77/km', '5,5 L', LatLng(16.2613042,-61.5544309),),
  Car('assets/images/cadillac.png', 90, 'Cadillac', '3A 9200', '77/km', '5,5 L', LatLng(16.2613042,-61.5502334),),
];



