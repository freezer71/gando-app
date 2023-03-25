

import 'dart:convert';

import 'package:gando/config/constants.dart';
import 'package:gando/services/provider/api_provider.dart';
import 'package:get/get.dart';

import '../../models/Car.dart';
import '../../models/User.dart';
import '../../models/UserCar.dart';

class CarService extends GetxService {

  final userID = ''.obs;

  final isLoading = false.obs;

  Future getUserId() async {
    try {
      final res = await ApiProvider().getData('/user');
      final body = jsonDecode(res.body)['data'];
      if (res.statusCode == 200) {
        userID(body['_id']);
        printInfo(info: 'USER ID ========>  : ${userID.value}');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 5));
      return [];
    } finally {
      isLoading(false);
    }
  }

  @override
  onInit() {
    super.onInit();
    // getUserId();
  }

  @override
  onClose() {
    super.onClose();
  }

  Future getCarBrands() async {
    try {
      final res = await ApiProvider().getData('/utils/carMarque');
      final body = jsonDecode(res.body)['data'];

      printInfo(info: 'CAR BRANDS ========>  : ${body}');

      if (res.statusCode == STATUS_OK) {
        return body;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 5));
      return [];
    } finally {
      isLoading(false);
    }
  }

  Future<List<Car>> fetchUserCarList() async {
    try {
      final res = await ApiProvider().getData('/annonce/userAnnonce');
      final body = jsonDecode(res.body)['data'];

      if (res.statusCode == STATUS_OK) {
        final List<Car> cars = body['cars'].map<Car>((json) => Car.fromJson(json)).toList();
        return cars;
      } else {
        return <Car>[];
      }
    }catch(e){
      Get.snackbar('Error', e.toString(),snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 15));
      printError(info: 'ERROR ========> lll  : ${e.toString()}');
      return <Car>[];
    } finally {
      isLoading(false);
    }
  }
}