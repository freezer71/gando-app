import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'Address.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: "_id")
  final String? id;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? nextEmail;
  final String? registrationDate;
  final String? accountType;
  final String? status;
  final String? loginType;
  final String? facebookId;
  final bool? isUserValidated;
  final List<String>? car;
  final String? phone;
  final String? nextPhone;
  final int? v;
  final String? dayOfBirth;
  final String? birthplace;
  final Address? address;
  final String? civility;
  final String? photo;
  final String? description;
  final bool? askingForValidation;
  final List<dynamic>? favouriteCar;
  final int? money;

  User({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.nextEmail,
    this.registrationDate,
    this.accountType,
    this.status,
    this.loginType,
    this.facebookId,
    this.isUserValidated,
    this.car,
    this.phone,
    this.nextPhone,
    this.v,
    this.dayOfBirth,
    this.birthplace,
    this.address,
    this.civility,
    this.photo,
    this.description,
    this.askingForValidation,
    this.favouriteCar,
    this.money,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
