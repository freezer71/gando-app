
// annotation
import 'package:json_annotation/json_annotation.dart';

part 'Images.g.dart';

@JsonSerializable()
class Images {
  String? avant34;
  String? lateral;
  String? ariere34;
  String? interieur;
  String? supplementaire;
  String? sId;

  Images(
      {this.avant34,
        this.lateral,
        this.ariere34,
        this.interieur,
        this.supplementaire,
        this.sId});

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}