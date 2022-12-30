import 'package:latlong2/latlong.dart';

class Car {
  String image;
  int price;
  String brand;
  String model;
  String co2;
  String fuelCons;
  LatLng? latLng;

  Car(
    this.image,
    this.price,
    this.brand,
    this.model,
    this.co2,
    this.fuelCons,
    this.latLng,
  );
}
