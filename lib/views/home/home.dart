import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:gando/config/config.dart';
import 'package:gando/config/constants.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/models/car.dart';
import 'package:gando/views/home/components/home_card.dart';
import 'package:gando/views/home/filters/big_filter_bottomsheet.dart';
import 'package:gando/views/home/filters/date_filter_range.dart';
import 'package:gando/views/products/available/available_car_screen.dart';
import 'package:gando/views/products/detail/widget/car_detail_infomation.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import '../products/available/widget/car_list_item.dart';

enum SingingCharacter { list, map }

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  GoogleMapController? mapController;
  SingingCharacter? _character = SingingCharacter.map;

  late TabController tabController;

  late bool activeTab = false;

  //contrller for Google map
  CameraPosition? cameraPosition;
  String location = "Tapez une adresse";
  late LatLng newlatlang = Config.latLng;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  late AnimationController _topColorAnimationController;

  Car car = carList[3];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    markers.clear();
    mapController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50.0), // here the desired height
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              bottom: TabBar(
                controller: tabController,
                indicatorColor: AppTheme.darkColor,
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.map_outlined,
                          color: AppTheme.darkColor.withOpacity(0.5),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Plan',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  color: AppTheme.darkColor),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.format_list_bulleted_rounded,
                          color: AppTheme.darkColor.withOpacity(0.5),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Liste',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  color: AppTheme.darkColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // appBar: PreferredSize(
          //   preferredSize: const Size.fromHeight(70.0),
          //   child: AppBar(
          //     shape: const RoundedRectangleBorder(
          //       borderRadius: BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
          //     ),
          //     backgroundColor: AppTheme.primaryColor,
          //     // brightness: _statusIconBrightness,
          //     elevation: 16,
          //     automaticallyImplyLeading: false,
          //     // title: Container(
          //     //   decoration: BoxDecoration(
          //     //     color: AppTheme.primaryColor,
          //     //     borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          //     //   ),
          //     //   child: TextButton(
          //     //       style: ButtonStyle(
          //     //         padding:  MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 12)),
          //     //         backgroundColor:
          //     //         MaterialStateProperty.resolveWith<Color>(
          //     //               (Set<MaterialState> states) => AppTheme.backgroundColor,
          //     //         ),
          //     //         overlayColor:
          //     //         MaterialStateProperty.all(Colors.transparent),
          //     //         shape: MaterialStateProperty.all(
          //     //             RoundedRectangleBorder(
          //     //               borderRadius: BorderRadius.circular(30.0),
          //     //             )),
          //     //       ),
          //     //       onPressed: () {
          //     //         // Navigator.push(
          //     //         //     context,
          //     //         //     MaterialPageRoute(
          //     //         //         builder: (context) => SearchPage()));
          //     //       },
          //     //       child: Row(
          //     //         children: [
          //     //           const SizedBox(width: 8),
          //     //           const Icon(
          //     //             Icons.search,
          //     //             color: Colors.grey,
          //     //           ),
          //     //           SizedBox(
          //     //             width: 100,
          //     //             child: Text(
          //     //               'Rechercher une adresse',
          //     //               maxLines: 1,
          //     //               style: TextStyle(
          //     //                   color: Colors.grey[500],
          //     //                   fontSize: 14,
          //     //                   overflow: TextOverflow.ellipsis,
          //     //                   fontWeight: FontWeight.normal),
          //     //             ),
          //     //           ),
          //     //         ],
          //     //       )),
          //     // ),
          //     actions: [
          //       ClipRRect(
          //         child: Container(
          //             width: 55,
          //             height: 50,
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(50),
          //               color: AppTheme.redColor,
          //             ),
          //             child: IconButton(onPressed: (){
          //               Get.bottomSheet(showFilterDateBottomSheet(context));
          //             }, icon: Icon(Icons.calendar_month,size: 25, color: AppTheme.backgroundColor.withOpacity(0.9)))),
          //       ),
          //       IconButton(
          //         padding: EdgeInsets.zero,
          //         // icon: _globalWidget.customNotifIcon(8, AppTheme.secondaryColor.withOpacity(0.5)),
          //           icon: Icon(Icons.sort_outlined, size: 30, color: AppTheme.backgroundColor.withOpacity(0.9)),
          //           onPressed: () {
          //             Get.bottomSheet(showFilterBottomSheet(context));
          //             // Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));
          //           }),
          //       Container(
          //         padding: const EdgeInsets.only(right: 5),
          //       )
          //     ],
          //     leadingWidth: 40,
          //     leading: Container(),
          //   ),
          // ),
          body: tabView(context, car),
        ),
      );

  Widget tabView(BuildContext context, car) {
    return TabBarView(
      controller: tabController,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            GoogleMap(
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              rotateGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                target: newlatlang,
                zoom: 14,
              ),
              gestureRecognizers: Set()
                ..add(Factory<EagerGestureRecognizer>(
                    () => EagerGestureRecognizer())),
              mapType: MapType.normal,
              markers: Set<Marker>.of(markers.values),
              onMapCreated: (controller) {
                //method called when map is created
                mapController = controller;
              },
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 80,
              child: GestureDetector(
                onVerticalDragUpdate: (c) {
                  setState(() {
                    tabController.index = 1;
                  });
                  // Get.to(
                  //   const AvailableCarScreen(),
                  //   transition: Transition.downToUp,
                  //   duration: const Duration(milliseconds: 500),
                  // );
                },
                child: SingleChildScrollView(
                  clipBehavior: Clip.antiAlias,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(carList.length, (index) => HomeCardCar(index,)),
                  ),
                ),
              ),
            ),
            buildAppBar()
          ],
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 120.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: carList.length,
                itemBuilder: (context, index) => CarListItem(index),
              ),
            ),
            buildAppBar()
          ],
        )
      ],
    );
  }

  Widget buildAppBar() => DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Positioned(
          width: Get.width,
          height: Get.height / 4.5,
          child: Container(
            padding: const EdgeInsets.only(top: 90, right: 0, left: 0),
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.transparent,
                  offset:  Offset(0.0, 0.0),
                  blurRadius: 10.0,
                  spreadRadius: 5,
                  blurStyle: BlurStyle.normal
                ),
              ],
            ),
            child: Stack(
              children: [
                SizedBox(
                  height: Get.height / 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          padding: EdgeInsets.zero,
                          // icon: _globalWidget.customNotifIcon(8, AppTheme.secondaryColor.withOpacity(0.5)),
                          icon: Icon(Icons.dehaze,
                              size: 30,
                              color: AppTheme.darkColor),
                          onPressed: () {
                            Get.bottomSheet(
                                showFilterBottomSheet(context));
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));
                          }),
                      Container(
                        width: Get.width / 1.52,
                        height: 45,
                        child: TextButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(horizontal: 10)),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) =>
                                    AppTheme.light,
                              ),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.black),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                            ),
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => SearchPage()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 180,
                                  child: Text(
                                    'Trouver une adresse',
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      ClipRRect(
                        child: Container(
                            width: 55,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppTheme.redColor,
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Get.bottomSheet(
                                      showFilterDateBottomSheet(
                                          context));
                                },
                                icon: Icon(Icons.calendar_month,
                                    size: 25,
                                    color: AppTheme.backgroundColor
                                        .withOpacity(0.9)))),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )));

  Widget buildSearchBox(context) {
    return Positioned(
      //search input bar
      top: 120,
      child: InkWell(
        onTap: () async {
          var place = await PlacesAutocomplete.show(
              context: context,
              apiKey: Config.googleApikey,
              mode: Mode.overlay,
              types: [],
              hint: 'Trouver l\'adresse',
              strictbounds: false,
              cursorColor: AppTheme.backgroundColor,
              textDecoration: InputDecoration(
                fillColor: AppTheme.backgroundColor,
                prefixIconColor: AppTheme.backgroundColor,
                enabled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 2.0,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  gapPadding: 8.0,
                ),
              ),
              components: [Component(Component.country, 'fr')],
              //google_map_webservice package
              onError: (err) {
                // print(err);
              });

          if (place != null) {
            setState(() {
              location = place.description.toString();
            });
            //form google_maps_webservice package
            final plist = GoogleMapsPlaces(
              apiKey: Config.googleApikey,
              apiHeaders: await GoogleApiHeaders().getHeaders(),
              //from google_api_headers package
            );
            String placeid = place.placeId ?? "0";
            final detail = await plist.getDetailsByPlaceId(placeid);
            final geometry = detail.result.geometry!;
            final lat = geometry.location.lat;
            final lang = geometry.location.lng;

            setState(() {
              newlatlang = LatLng(lat, lang);
              var markerIdVal = lat + lang;
              final MarkerId markerId = MarkerId(markerIdVal.toString());
              // creating a new MARKER
              final Marker marker = Marker(
                markerId: markerId,
                position: newlatlang,
                infoWindow:
                    InfoWindow(title: markerIdVal.toString(), snippet: '*'),
                onTap: () {
                  // _onMarkerTapped(markerId);
                },
              );
              // adding a new marker to map
              markers[markerId] = marker;

              //move map camera to selected place with animation
              mapController?.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: newlatlang, zoom: 17)));
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Card(
            color: Colors.transparent,
            elevation: 0,
            child: Container(
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                width: MediaQuery.of(context).size.width - 40,
                child: ListTile(
                  title: Text(
                    location,
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Icon(
                    Icons.search,
                    color: AppTheme.backgroundColor,
                  ),
                  dense: true,
                )),
          ),
        ),
      ),
    );
  }

  BottomSheet showFilterDateBottomSheet(context) {
    return BottomSheet(
        backgroundColor: Colors.transparent,
        onClosing: () {},
        builder: (c) {
          return DateFilterRange();
        });
  }

  BottomSheet showFilterBottomSheet(context) {
    return BottomSheet(
        backgroundColor: Colors.transparent,
        onClosing: () {},
        builder: (c) {
          return Filters();
        });
  }
}
