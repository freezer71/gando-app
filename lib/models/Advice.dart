
import 'package:json_annotation/json_annotation.dart';

part 'Advice.g.dart';

@JsonSerializable()
class Advice {
  final String? id;
  final String? user;
  final int? note;
  final String? comment;
  final String? car;
  final int? v;

  Advice({
    this.id,
    this.user,
    this.note,
    this.comment,
    this.car,
    this.v,
  });

  factory Advice.fromJson(Map<String, dynamic> json) => _$AdviceFromJson(json);

  Map<String, dynamic> toJson() => _$AdviceToJson(this);
}