import 'package:json_annotation/json_annotation.dart';
import 'Notification.dart';

part 'Owner.g.dart';

@JsonSerializable()
class Owner {
  final int? money;
  final bool? askingForValidation;
  final List<dynamic>? favouriteCar;
  final Notification? notification;
  final String? id;
  final String? nextEmail;
  final String? registrationDate;
  final String? accountType;
  final String? status;
  final int? forgotValidedCode;
  final String? loginType;
  final String? facebookId;
  final bool? isUserValidated;
  final List<dynamic>? car;
  final String? phone;
  final String? nextPhone;
  final String? phoneValidationCode;
  final int? v;

  Owner({
    this.money,
    this.askingForValidation,
    this.favouriteCar,
    this.notification,
    this.id,
    this.nextEmail,
    this.registrationDate,
    this.accountType,
    this.status,
    this.forgotValidedCode,
    this.loginType,
    this.facebookId,
    this.isUserValidated,
    this.car,
    this.phone,
    this.nextPhone,
    this.phoneValidationCode,
    this.v,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerToJson(this);

}