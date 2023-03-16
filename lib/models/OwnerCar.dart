
import 'package:json_annotation/json_annotation.dart';

part 'OwnerCar.g.dart';

@JsonSerializable()
class OwnerCar {
  @JsonKey(name: '_id')
  final String? id;
  final String? registrationDate;
  final String? picture;
  final int? success_reservation_count;
  final String? prenom;
  final String? photo;

  OwnerCar({
    required this.id,
    required this.registrationDate,
    required this.picture,
    required this.success_reservation_count,
    required this.prenom,
    required this.photo,
  });

  factory OwnerCar.fromJson(Map<String, dynamic> json) => _$OwnerCarFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerCarToJson(this);
}