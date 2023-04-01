import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  @JsonKey(name: "_id")
  final String? id;
  final String? body;
  final String? sender;
  final String? recipient;
  final String? discussion;
  final bool? seen;
  final DateTime? sendDate;
  final String? annonce;
  final int? v;

  Chat(
      {this.id,
      this.body,
      this.sender,
      this.recipient,
      this.discussion,
      this.seen,
      this.sendDate,
      this.annonce,
      this.v});

  //serialization
  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  //deserialization
  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
