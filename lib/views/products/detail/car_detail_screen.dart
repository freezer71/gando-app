
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/config.dart';
import 'package:gando/models/Car.dart';
import 'package:gando/views/products/detail/widget/car_detail_infomation.dart';
import 'package:gando/views/products/detail/widget/my_appbar.dart';

class CarDetailScreen extends StatelessWidget {
  final Car car;

  CarDetailScreen(this.car);

  // GoogleMapController? mapController;

  //contrller for Google map
  // CameraPosition? cameraPosition;

  String location = "Tapez une adresse";

  // late LatLng newlatlang = Config.latLng;

  // Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Stack(
          children: [
         /*   GoogleMap(
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              rotateGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                target: newlatlang,
                zoom: 15,
              ),
              gestureRecognizers: Set()
                ..add(Factory<EagerGestureRecognizer>(
                        () => EagerGestureRecognizer())),
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: Set<Marker>.of(markers.values),
              onMapCreated: (controller) async{
                //method called when map is created
                mapController = controller;
              },
            ),*/
            const MyAppbar(),
            Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: Stack(
                children: [
                  CarDetailInfomation(car: car),
                  Positioned(
                    right: 16,
                    child: Image.asset(
                      car.image,
                      height: 100,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

