
import 'package:json_annotation/json_annotation.dart';

part 'Address.g.dart';

@JsonSerializable()
class Address {
  final String? addresse;
  final String? complement;
  final String? country;
  final String? city;
  final String? zipCode;
  final String? id;

  Address({
    this.addresse,
    this.complement,
    this.country,
    this.city,
    this.zipCode,
    this.id,
  });

  //serialization
  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  //deserialization
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}