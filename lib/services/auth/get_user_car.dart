

import 'dart:convert';

import 'package:gando/config/constants.dart';
import 'package:gando/services/provider/api_provider.dart';
import 'package:get/get.dart';

import '../../models/Car.dart';
import '../../models/User.dart';
import '../../models/UserCar.dart';

class CarService extends GetxService {

  final userID = ''.obs;

  Future<List<UserCar>> fetchUserCarList() async {
    await ApiProvider().getData('/user').then((value) {
      final body = jsonDecode(value.body)['data'];
      userID.value = body['_id'];
    });

    final res = await ApiProvider().getData('/car/getUserCars?userId=$userID');
    final body = jsonDecode(res.body)['data'];

    if (res.statusCode == 200) {
      final List<UserCar> cars = body.map<UserCar>((json) => UserCar.fromJson(json)).toList();
      return cars;
    } else {
      throw Exception('Failed to load cars');
    }
  }
}