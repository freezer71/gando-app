
import 'package:json_annotation/json_annotation.dart';
import 'Advice.dart';
import 'Images.dart';
import 'Location.dart';
import 'Owner.dart';

part 'Car.g.dart';


@JsonSerializable()
class Car {
  final String? status;
  final String? id;
  final String? brand;
  final String? model;
  final String? type;
  final Location? location;
  final int? year;
  final int? mileage;
  final String? licensePlate;
  final String? gearbox;
  final String? fuel;
  final String? nextTechnicalInspection;
  final int? numberOfPlaces;
  final int? numberOfDoors;
  final double? note;
  final List<String>? equipment;
  final Owner? owner;
  final bool? isCreated;
  final Images? images;
  final List<dynamic>? disponibility;
  final int? creationStep;
  final int? pricePerDay;
  final int? pricePerWeek;
  final int? pricePerMonth;
  final bool? youngDriver;
  final String? city;
  final String? zipCode;
  final String? address;
  final String? description;
  final String? nextTechnicalInspectionImage;
  final List<Advice>? advice;
  final int? v;

  Car({
    this.status,
    this.id,
    this.brand,
    this.model,
    this.type,
    this.location,
    this.year,
    this.mileage,
    this.licensePlate,
    this.gearbox,
    this.fuel,
    this.nextTechnicalInspection,
    this.numberOfPlaces,
    this.numberOfDoors,
    this.note,
    this.equipment,
    this.owner,
    this.isCreated,
    this.images,
    this.disponibility,
    this.creationStep,
    this.pricePerDay,
    this.pricePerWeek,
    this.pricePerMonth,
    this.youngDriver,
    this.city,
    this.zipCode,
    this.address,
    this.description,
    this.nextTechnicalInspectionImage,
    this.advice,
    this.v,
  });

  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);

  Map<String, dynamic> toJson() => _$CarToJson(this);
}


class LocationAsk {
  final bool? app;
  final bool? sMS;
  final bool? mail;

  LocationAsk({
    this.app,
    this.sMS,
    this.mail,
  });

  LocationAsk.fromJson(Map<String, dynamic> json)
      : app = json['app'] as bool?,
        sMS = json['SMS'] as bool?,
        mail = json['mail'] as bool?;

  Map<String, dynamic> toJson() => {
    'app' : app,
    'SMS' : sMS,
    'mail' : mail
  };
}

class RentConfirmation {
  final bool? app;
  final bool? sMS;
  final bool? mail;

  RentConfirmation({
    this.app,
    this.sMS,
    this.mail,
  });

  RentConfirmation.fromJson(Map<String, dynamic> json)
      : app = json['app'] as bool?,
        sMS = json['SMS'] as bool?,
        mail = json['mail'] as bool?;

  Map<String, dynamic> toJson() => {
    'app' : app,
    'SMS' : sMS,
    'mail' : mail
  };
}

class Message {
  final bool? app;
  final bool? mail;

  Message({
    this.app,
    this.mail,
  });

  Message.fromJson(Map<String, dynamic> json)
      : app = json['app'] as bool?,
        mail = json['mail'] as bool?;

  Map<String, dynamic> toJson() => {
    'app' : app,
    'mail' : mail
  };
}

class RentAbort {
  final bool? app;
  final bool? sMS;
  final bool? mail;

  RentAbort({
    this.app,
    this.sMS,
    this.mail,
  });

  RentAbort.fromJson(Map<String, dynamic> json)
      : app = json['app'] as bool?,
        sMS = json['SMS'] as bool?,
        mail = json['mail'] as bool?;

  Map<String, dynamic> toJson() => {
    'app' : app,
    'SMS' : sMS,
    'mail' : mail
  };
}

class Contract {
  final bool? app;
  final bool? sMS;
  final bool? mail;

  Contract({
    this.app,
    this.sMS,
    this.mail,
  });

  Contract.fromJson(Map<String, dynamic> json)
      : app = json['app'] as bool?,
        sMS = json['SMS'] as bool?,
        mail = json['mail'] as bool?;

  Map<String, dynamic> toJson() => {
    'app' : app,
    'SMS' : sMS,
    'mail' : mail
  };
}

class Pay {
  final bool? app;
  final bool? mail;

  Pay({
    this.app,
    this.mail,
  });

  Pay.fromJson(Map<String, dynamic> json)
      : app = json['app'] as bool?,
        mail = json['mail'] as bool?;

  Map<String, dynamic> toJson() => {
    'app' : app,
    'mail' : mail
  };
}