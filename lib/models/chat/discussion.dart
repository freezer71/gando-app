import 'package:gando/models/User.dart';
import 'package:gando/models/chat/chat.dart';
import 'package:json_annotation/json_annotation.dart';

part 'discussion.g.dart';

@JsonSerializable()
class Discussion {
  @JsonKey(name: "_id")
  final String? id;
  final String? sender;
  final String? recipient;
  final List<String>? messages;
  final List<Chat>? lastMessage;
  final DateTime? updateDate;
  final List<User>? anotherUser;
  final bool? seen;

  Discussion({
    this.id,
    this.sender,
    this.recipient,
    this.seen,
    this.lastMessage,
    this.messages,
    this.updateDate,
    this.anotherUser,
  });

  //serialization
  factory Discussion.fromJson(Map<String, dynamic> json) =>
      _$DiscussionFromJson(json);

  //deserialization
  Map<String, dynamic> toJson() => _$DiscussionToJson(this);
}
