import 'Car.dart';

class ProfileSeller {
  String name;
  String image;
  String description;
  int bookingCount;
  int garage;
  List<Car> cars;
  bool isRecommended;
  String rate;
  DateTime createdAt;

  ProfileSeller(
      this.name,
      this.image,
      this.description,
      this.bookingCount,
      this.garage,
      this.cars,
      this.isRecommended,
      this.rate,
      this.createdAt,
      );
}