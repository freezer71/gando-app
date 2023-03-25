import 'package:json_annotation/json_annotation.dart';

part 'CarBrandModel.g.dart';

@JsonSerializable()
class CarBrand {

  @JsonKey(name: '_id') final String id;
  final String name;
  final List<CarModel> models;

  CarBrand(this.id, this.name, this.models);

  factory CarBrand.fromJson(Map<String, dynamic> json) =>
      _$CarBrandFromJson(json);

  Map<String, dynamic> toJson() => _$CarBrandToJson(this);
}

@JsonSerializable()
class CarModel {
  @JsonKey(name: '_id') final String id;
  final String name;

  CarModel(this.id, this.name);

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);

  Map<String, dynamic> toJson() => _$CarModelToJson(this);
}
