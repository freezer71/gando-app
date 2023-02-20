
// annotation
import 'package:json_annotation/json_annotation.dart';

import 'Images.dart';
import 'Location.dart';

part 'UserCar.g.dart';


@JsonSerializable()
class UserCar {
  UserCar({
    required this.id,
    required this.brand,
    // required this.address,
    required this.status,
    required this.images,
  });
  @JsonKey(name: '_id') String id;
  String brand;
  // @JsonKey(name: 'address') String address;
  String status;
  Images images;

  factory UserCar.fromJson(Map<String, dynamic> json) => _$UserCarFromJson(json);

  Map<String, dynamic> toJson() => _$UserCarToJson(this);
}
