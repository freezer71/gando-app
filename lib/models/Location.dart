
import 'package:json_annotation/json_annotation.dart';

part 'Location.g.dart';

@JsonSerializable()
class Location {
  final String? type;
  final List? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}