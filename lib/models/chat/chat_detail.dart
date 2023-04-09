import 'package:gando/models/User.dart';
import 'package:gando/models/chat/chat.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_detail.g.dart';

@JsonSerializable()
class ChatDetailModel {
  @JsonKey(name: "_id")
  final String? id;
  final String? sender;
  final String? recipient;
  final List<Chat>? messages;
  final DateTime? updateDate;

  ChatDetailModel({
    this.id,
    this.sender,
    this.recipient,
    this.messages,
    this.updateDate,
  });

  //serialization
  factory ChatDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ChatDetailModelFromJson(json);

  //deserialization
  Map<String, dynamic> toJson() => _$ChatDetailModelToJson(this);
}
