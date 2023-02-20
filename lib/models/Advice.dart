
import 'package:json_annotation/json_annotation.dart';

part 'Advice.g.dart';

@JsonSerializable()
class Advice {
  @JsonKey(name: '_id') final String? id;
  final String? user;
  final int? note;
  final String? comment;
  final String? car;

  Advice({
    required this.id,
    required this.user,
    required this.note,
    required this.comment,
    required this.car,
  });

  factory Advice.fromJson(Map<String, dynamic> json) => _$AdviceFromJson(json);

  Map<String, dynamic> toJson() => _$AdviceToJson(this);
}