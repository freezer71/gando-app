import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gando/controllers/car_controller.dart';
import 'package:gando/generated/assets.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../models/Car.dart';

const String TOKEN_MAP = 'pk.eyJ1IjoiY2F2aWFyb3MiLCJhIjoiY2xjMW90MWx3MTFhajNwbXpmaXlreHI5diJ9.mPwJumFFjJCjq45E-17_QQ';
const String MAP_URL_LIGHT = 'https://api.mapbox.com/styles/v1/caviaros/clc1ppt3l000714p9rtrajii2/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiY2F2aWFyb3MiLCJhIjoiY2xjMW90MWx3MTFhajNwbXpmaXlreHI5diJ9.mPwJumFFjJCjq45E-17_QQ';
const String MAP_URL_DARK = "https://api.mapbox.com/styles/v1/caviaros/clc1oz5yc001p14ox3uvw1ynu/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiY2F2aWFyb3MiLCJhIjoiY2xjMW90MWx3MTFhajNwbXpmaXlreHI5diJ9.mPwJumFFjJCjq45E-17_QQ";
const String MAP_STYLE = 'mapbox://styles/caviaros/clc1oz5yc001p14ox3uvw1ynu';


//API PROVIDER ----------------------
const String APP_URL ='https://mygando.com';
const String API_URL = kDebugMode ? 'https://dev.mygando.com' : 'https://api.mygando.com';
const String APP_FILE = 'https://mygando.com/file/public/';

const int STATUS_OK = 200;
const int STATUS_BAD_REQUEST = 400;
const int STATUS_NOT_AUTHORIZED = 403;
const int STATUS_NOT_FOUND = 404;
const int STATUS_INTERNAL_ERROR = 500;

const String ERROR_OCCURED =
    'Une erreur s\'est produite, veuillez réessayer plus tard';

const Color mPrimaryColor = Color(0xFF40ac9c);

const Color mCardColor = Color(0xFF203e5a);


// fake car list
List<Car> carList = [
    ...CarController().carList
] ;



