import 'package:json_annotation/json_annotation.dart';

part 'notification_choice.g.dart';

@JsonSerializable()
class NotificationChoice {
  final bool? app;
  final bool? mail;
  final bool? sms;

  NotificationChoice({this.app, this.mail, this.sms});

  factory NotificationChoice.fromJson(Map<String, dynamic> json) =>
      _$NotificationChoiceFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationChoiceToJson(this);
}
