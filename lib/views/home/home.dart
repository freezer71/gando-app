import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/car_controller.dart';
import 'package:gando/helpers/global_function.dart';

// imprt constants
import 'package:gando/config/constants.dart';
import 'package:gando/models/Car.dart';
import 'package:gando/views/home/components/home_card.dart';
import 'package:gando/views/home/filters/big_filter_bottomsheet.dart';
import 'package:gando/views/home/filters/date_filter_range.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart' as LottieFiles;

import '../../generated/assets.dart';

enum SingingCharacter { list, map }

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  SingingCharacter? _character = SingingCharacter.map;

  late TabController tabController;

  late bool activeTab = false;
  final scrollController = ScrollController();

  String location = "Tapez une adresse";
  late AnimationController _topColorAnimationController;

  // final controller = Get.put(CarController());
  final gf = GlobalFunction();

  //map
  final PopupController _popupController = PopupController();

  final _mapController = MapController();

  final double _zoom = 7;
  final List<LatLng> _latLngList = [
    LatLng(13, 77.5),
    LatLng(13.02, 77.51),
    LatLng(13.05, 77.53),
    LatLng(13.055, 77.54),
    LatLng(13.059, 77.55),
    LatLng(13.07, 77.55),
    LatLng(13.1, 77.5342),
    LatLng(13.12, 77.51),
    LatLng(13.015, 77.53),
    LatLng(13.155, 77.54),
    LatLng(13.159, 77.55),
    LatLng(13.17, 77.55),
  ];

  Widget _priceMarker(price) {
    return Text(
      '${price} €',
      style: TextStyle(
        color: AppTheme.primaryColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  List<Marker> _buildMarkers(carList) {
    final markers = <Marker>[];
    for (var i = 0; i < carList.length; i++) {
      final mapItem = carList[i];
      markers.add(
        Marker(
          width: 60,
          height: 60,
          point: LatLng(
              mapItem.location.coordinates[1], mapItem.location.coordinates[0]),
          builder: (context) => _priceMarker(carList[i].pricePerDay),
        ),
      );
    }
    return markers;
  }

  // late Car car;
  // late List<Car>? carList;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }


  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          // here the desired height
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            bottom: TabBar(
              controller: tabController,
              indicatorColor: AppTheme.darkColor,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              indicatorWeight: 3,
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
                        style: Theme
                            .of(context)
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
                        style: Theme
                            .of(context)
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
        body: tabView(context),
        bottomNavigationBar: Container(height: 50, color: AppTheme.light,),
      ),
    );
  }

  Widget tabView(BuildContext context) {
    return GetBuilder<CarController>(
      assignId: true,
      init: CarController(),
      autoRemove: false,
      builder: (controller) {
        return TabBarView(
          controller: tabController,
          children: [
            FutureBuilder(
              future: controller.futureGetCar,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Une erreur est survenue'),
                  );
                } else if (snapshot.hasData) {
                  final data = <Car>[];
                  data.addAll(snapshot.data);
                  if (!data.isNotEmpty) {
                    return Stack(
                      children: [
                        FlutterMap(
                          mapController: _mapController,
                          options: MapOptions(
                            zoom: 10,
                            maxZoom: 16,
                            minZoom: 2,
                            center: LatLng(16.258052, -61.566089),
                            // rotation: 180.0,
                            keepAlive: true,
                            enableScrollWheel: true,
                            scrollWheelVelocity: 0.003,
                            onPositionChanged: (MapPosition position,
                                bool hasGesture) {
                              // Your logic here. `hasGesture` dictates whether the change
                              // was due to a user interaction or something else. `

                              // if (hasGesture) {
                              //   // Your logic here.
                              // }
                            },
                          ),
                          children: [
                            TileLayer(
                              urlTemplate: MAP_URL_DARK,
                              userAgentPackageName: 'com.gando.rentcar.app',
                              additionalOptions: const {
                                'accessToken': TOKEN_MAP,
                                'id': MAP_STYLE
                              },
                              retinaMode: MediaQuery
                                  .of(context)
                                  .devicePixelRatio > 1.0,
                              // tileBounds: LatLngBounds(
                              //   LatLng(32.2934590056236, 24.328924534719548),
                              //   LatLng(21.792152188247265, 37.19854583903912),
                              // ),
                              errorImage: const NetworkImage(
                                  'https://tile.openstreetmap.org/18/0/0.png'),
                            ),
                            MarkerLayer(
                              markers: _buildMarkers(data),
                            ),
                          ],
                        ),
                        Positioned(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: AppTheme.light,
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20))
                              ),
                              height: Platform.isAndroid ? 160 : 180),),
                        buildAppBar(),
                      ],
                    );
                  } else {
                    final initialCoordinates = LatLng(
                        data.first.location!.coordinates![1],
                        data.first.location!.coordinates![0]);

                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        FlutterMap(
                          mapController: _mapController,
                          options: MapOptions(
                            zoom: 9,
                            maxZoom: 16,
                            minZoom: 2,
                            center: initialCoordinates,
                            // rotation: 180.0,
                            keepAlive: true,
                            enableScrollWheel: true,
                            scrollWheelVelocity: 0.003,
                            onPositionChanged: (MapPosition position,
                                bool hasGesture) {
                              // Your logic here. `hasGesture` dictates whether the change
                              // was due to a user interaction or something else. `position` is
                              // the new position of the map.
                              // print(position.center!.toString());

                              // get annonce by location
                              // controller.getAnnonceByLocation(position.center!.latitude, position.center!.longitude, 10);
                            },
                          ),
                          children: [
                            TileLayer(
                              urlTemplate: MAP_URL_DARK,
                              userAgentPackageName: 'com.gando.rentcar.app',
                              additionalOptions: const {
                                'accessToken': TOKEN_MAP,
                                'id': MAP_STYLE
                              },
                              retinaMode: MediaQuery
                                  .of(context)
                                  .devicePixelRatio > 1.0,
                              // tileBounds: LatLngBounds(
                              //   LatLng(32.2934590056236, 24.328924534719548),
                              //   LatLng(21.792152188247265, 37.19854583903912),
                              // ),
                              errorImage: const NetworkImage(
                                  'https://tile.openstreetmap.org/18/0/0.png'),
                              // tileBuilder: (context, widget, tile) =>
                              //     Stack(
                              //       fit: StackFit.passthrough,
                              //       children: [
                              //         widget,
                              //         Center(
                              //           child:
                              //           Text('${tile.coords.x.floor()} : ${tile.coords.y.floor()} : ${tile.coords.z.floor()}'),
                              //         ),
                              //       ],
                              //     )
                            ),
                            MarkerLayer(
                                rotate: true,
                                markers: _buildMarkers(controller.carList)
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  rotate: false,
                                  // get my location
                                  point: initialCoordinates,
                                  width: 50,
                                  height: 50,
                                  builder: (context) =>
                                  GlobalFunction.myLocationLottieFile,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: Get.height / 8,
                          child: GestureDetector(
                            onVerticalDragUpdate: (c) {
                              // setState(() {
                              //   tabController.index = 1;
                              // });
                            },
                            child: Container(
                              height: Get.height / 3.8,
                              // margin: const EdgeInsets.only(top: 80.0),
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.zero,
                                itemCount: data.length,
                                itemBuilder: (context, index) =>
                                    HomeCardCar(index, data[index]),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: AppTheme.light,
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20))
                              ),
                              height: Platform.isAndroid ? 160 : 180),),
                        buildAppBar(),
                      ],
                    );
                  }
                }

                return Container();
              },
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 0.0),
                  child: Obx(() {
                    return ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.only(top: 180, bottom: 120),
                      itemCount: controller.carList.length,
                      itemBuilder: (context, index) =>
                          HomeCardCar(index, controller.carList[index]),
                    );
                  }),
                ),
                Positioned(child: Container(
                    decoration: BoxDecoration(
                        color: AppTheme.light,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))
                    ),
                    height: Platform.isAndroid ? 160 : 180)),
                buildAppBar(),
              ],
            )
          ],
        );
      },
    );
  }

  Widget buildAppBar() =>
      DefaultTabController(
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
                  // boxShadow: [
                  //   BoxShadow(
                  //       color: Colors.transparent,
                  //       offset: Offset(0.0, 0.0),
                  //       blurRadius: 10.0,
                  //       spreadRadius: 5,
                  //       blurStyle: BlurStyle.normal
                  //   ),
                  // ],
                ),
                child: SizedBox(
                  height: Get.height / 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Expanded(child: const SizedBox()),
                      SizedBox(
                        width: Get.width - 90,
                        child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: TextButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.only(left: 10)),
                                backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) =>
                                  AppTheme.darkColor,
                                ),
                                overlayColor:
                                MaterialStateProperty.all(Colors.black),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    )),
                              ),
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => SearchPage()));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.location_on_outlined,
                                      color: Colors.grey),
                                  SizedBox(
                                    width: Get.width / 2.3,
                                    child: Text(
                                      'Adresse, lieu',
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 14,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.normal),

                                    ),
                                  ),
                                  Expanded(child: const SizedBox()),
                                  Container(
                                      margin: EdgeInsets.zero,
                                      padding: EdgeInsets.zero,
                                      decoration: BoxDecoration(
                                        color: AppTheme.redColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            Get.bottomSheet(
                                                showFilterDateBottomSheet(
                                                    context));
                                          },
                                          icon: Icon(Icons.calendar_month,
                                              size: 25,
                                              color: AppTheme.backgroundColor
                                                  .withOpacity(0.9))))
                                ],
                              )),
                        ),
                      ),
                      const Expanded(child: const SizedBox(width: 10,)),
                      IconButton(
                        // icon: _globalWidget.customNotifIcon(8, AppTheme.secondaryColor.withOpacity(0.5)),
                          icon: SvgPicture.asset(Assets.svgVector, width: 30,
                            color: AppTheme.darkColor,),
                          onPressed: () {
                            Get.bottomSheet(
                                showFilterBottomSheet(context));
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));
                          }),
                      const Expanded(child: const SizedBox()),
                    ],
                  ),
                ),
              )));

  Widget buildSearchBox(context) {
    return Positioned(
      //search input bar
      top: 120,
      child: InkWell(
        onTap: () async {

        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Card(
            color: Colors.transparent,
            elevation: 0,
            child: Container(
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 40,
                child: ListTile(
                  title: Text(
                    location,
                    style: const TextStyle(fontSize: 18),
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
        enableDrag: true,
        builder: (c) {
          return FractionallySizedBox(
            heightFactor: 1.9,
            child: Filters(),
          );
        });
  }
}
