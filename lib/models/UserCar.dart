// To parse this JSON data, do
//
//     final userCar = userCarFromJson(jsonString);

import 'dart:convert';

UserCar userCarFromJson(String str) => UserCar.fromJson(json.decode(str));

String userCarToJson(UserCar data) => json.encode(data.toJson());

class UserCar {
  UserCar({
    required this.status,
    required this.id,
    required this.brand,
    required this.model,
    required this.type,
    required this.location,
    required this.year,
    required this.mileage,
    required this.licensePlate,
    required this.gearbox,
    required this.fuel,
    required this.nextTechnicalInspection,
    required this.numberOfPlaces,
    required this.numberOfDoors,
    required this.note,
    required this.equipment,
    required this.owner,
    required this.isCreated,
    required this.images,
    required this.disponibility,
    required this.creationStep,
    required this.pricePerDay,
    required this.pricePerWeek,
    required this.pricePerMonth,
    required this.youngDriver,
    required this.city,
    required this.zipCode,
    required this.address,
    required this.description,
    required this.nextTechnicalInspectionImage,
    required this.advice,
    required this.v,
  });

  String status;
  String id;
  String brand;
  String model;
  String type;
  Location location;
  int year;
  int mileage;
  String licensePlate;
  String gearbox;
  String fuel;
  DateTime nextTechnicalInspection;
  int numberOfPlaces;
  int numberOfDoors;
  int note;
  List<String> equipment;
  String owner;
  bool isCreated;
  Images images;
  List<dynamic> disponibility;
  int creationStep;
  int pricePerDay;
  int pricePerWeek;
  int pricePerMonth;
  bool youngDriver;
  String city;
  String zipCode;
  String address;
  String description;
  String nextTechnicalInspectionImage;
  List<String> advice;
  int v;

  factory UserCar.fromJson(Map<String, dynamic> json) => UserCar(
    status: json["status"],
    id: json["_id"],
    brand: json["brand"],
    model: json["model"],
    type: json["type"],
    location: Location.fromJson(json["location"]),
    year: json["year"],
    mileage: json["mileage"],
    licensePlate: json["licensePlate"],
    gearbox: json["gearbox"],
    fuel: json["fuel"],
    nextTechnicalInspection: DateTime.parse(json["nextTechnicalInspection"]),
    numberOfPlaces: json["numberOfPlaces"],
    numberOfDoors: json["numberOfDoors"],
    note: json["note"],
    equipment: List<String>.from(json["equipment"].map((x) => x)),
    owner: json["owner"],
    isCreated: json["isCreated"],
    images: Images.fromJson(json["images"]),
    disponibility: List<dynamic>.from(json["disponibility"].map((x) => x)),
    creationStep: json["creationStep"],
    pricePerDay: json["pricePerDay"],
    pricePerWeek: json["pricePerWeek"],
    pricePerMonth: json["pricePerMonth"],
    youngDriver: json["youngDriver"],
    city: json["city"],
    zipCode: json["zipCode"],
    address: json["address"],
    description: json["description"],
    nextTechnicalInspectionImage: json["nextTechnicalInspectionImage"],
    advice: List<String>.from(json["advice"].map((x) => x)),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "_id": id,
    "brand": brand,
    "model": model,
    "type": type,
    "location": location.toJson(),
    "year": year,
    "mileage": mileage,
    "licensePlate": licensePlate,
    "gearbox": gearbox,
    "fuel": fuel,
    "nextTechnicalInspection": nextTechnicalInspection.toIso8601String(),
    "numberOfPlaces": numberOfPlaces,
    "numberOfDoors": numberOfDoors,
    "note": note,
    "equipment": List<dynamic>.from(equipment.map((x) => x)),
    "owner": owner,
    "isCreated": isCreated,
    "images": images.toJson(),
    "disponibility": List<dynamic>.from(disponibility.map((x) => x)),
    "creationStep": creationStep,
    "pricePerDay": pricePerDay,
    "pricePerWeek": pricePerWeek,
    "pricePerMonth": pricePerMonth,
    "youngDriver": youngDriver,
    "city": city,
    "zipCode": zipCode,
    "address": address,
    "description": description,
    "nextTechnicalInspectionImage": nextTechnicalInspectionImage,
    "advice": List<dynamic>.from(advice.map((x) => x)),
    "__v": v,
  };
}

class Images {
  Images({
    required this.avant34,
    required this.lateral,
    required this.ariere34,
    required this.interieur,
    required this.supplementaire,
    required this.id,
  });

  String avant34;
  String lateral;
  String ariere34;
  String interieur;
  String supplementaire;
  String id;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    avant34: json["avant34"],
    lateral: json["lateral"],
    ariere34: json["ariere34"],
    interieur: json["interieur"],
    supplementaire: json["supplementaire"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "avant34": avant34,
    "lateral": lateral,
    "ariere34": ariere34,
    "interieur": interieur,
    "supplementaire": supplementaire,
    "_id": id,
  };
}

class Location {
  Location({
    required this.lat,
    required this.long,
    required this.id,
  });

  String lat;
  String long;
  String id;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"],
    long: json["long"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "long": long,
    "_id": id,
  };
}
