import 'package:latlong2/latlong.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Car {
  Car(
    this.image,
    this.price,
    this.brand,
    this.model,
    this.co2,
    this.fuelCons,
    this.latLng,
  );

  String image;
  int price;
  String brand;
  String model;
  String co2;
  String fuelCons;
  LatLng? latLng;


}
