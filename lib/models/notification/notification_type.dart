import 'package:gando/models/notification/notification_choice.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_type.g.dart';

@JsonSerializable()
class NotificationType {
  final NotificationChoice? locationAsk;
  final NotificationChoice? rentConfirmation;
  final NotificationChoice? message;
  final NotificationChoice? rentAbort;
  final NotificationChoice? contract;
  final NotificationChoice? pay;

  NotificationType({
    this.locationAsk,
    this.rentConfirmation,
    this.message,
    this.rentAbort,
    this.contract,
    this.pay,
  });

  factory NotificationType.fromJson(Map<String, dynamic> json) =>
      _$NotificationTypeFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationTypeToJson(this);
}
