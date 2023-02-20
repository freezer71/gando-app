

//import serialization
import 'package:json_annotation/json_annotation.dart';
import 'Car.dart';

part 'Notification.g.dart';

@JsonSerializable()
class Notification {
  final LocationAsk? locationAsk;
  final RentConfirmation? rentConfirmation;
  final Message? message;
  final RentAbort? rentAbort;
  final Contract? contract;
  final Pay? pay;
  final String? id;

  Notification({
    this.locationAsk,
    this.rentConfirmation,
    this.message,
    this.rentAbort,
    this.contract,
    this.pay,
    this.id,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);

}