
// annotation
import 'package:gando/models/Car.dart';
import 'package:gando/models/Owner.dart';
import 'package:json_annotation/json_annotation.dart';

import 'Images.dart';
import 'Location.dart';
import 'OwnerCar.dart';

part 'UserCar.g.dart';

@JsonSerializable()
class UserCar {
  final OwnerCar owner;
  final List<Car>? cars;

  UserCar({
    required this.owner,
    required this.cars,
  });

  factory UserCar.fromJson(Map<String, dynamic> json) => _$UserCarFromJson(json);

  Map<String, dynamic> toJson() => _$UserCarToJson(this);
}