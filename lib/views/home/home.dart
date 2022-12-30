import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
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
import 'package:latlong2/latlong.dart';

import '../products/available/widget/car_list_item.dart';

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
  List<Marker> _markers = [];

  Car car = carList[3];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    _markers = _latLngList
        .map((point) => Marker(
      point: point,
      width: 60,
      height: 60,
      builder: (context) => const Icon(
        Icons.pin_drop,
        size: 60,
        color: Colors.blueAccent,
      ),
    )).toList();
  }


  @override
  void dispose() {
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
                indicatorColor: AppTheme.light,
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.map_outlined,
                          color: AppTheme.light.withOpacity(0.5),
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
                                  color: AppTheme.light),
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
                          color: AppTheme.light.withOpacity(0.5),
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
                                  color: AppTheme.light),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: tabView(context, car),
        ),
      );

  Widget tabView(BuildContext context, Car car) {
    return TabBarView(
      controller: tabController,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              foregroundDecoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent, Colors.transparent, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0032, 0.3, 0.85, 4],
                ),
              ),
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  zoom: 13.0,
                  maxZoom: 18.0,
                  center: car.latLng,
                  // rotation: 180.0,
                  keepAlive: true,
                  enableScrollWheel: true,
                  scrollWheelVelocity: 0.005,
                  // onPositionChanged: (MapPosition position, bool hasGesture) {
                  //   // Your logic here. `hasGesture` dictates whether the change
                  //   // was due to a user interaction or something else. `position` is
                  //   // the new position of the map.
                  // },
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://api.mapbox.com/styles/v1/caviaros/clc1ppt3l000714p9rtrajii2/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiY2F2aWFyb3MiLCJhIjoiY2xjMW90MWx3MTFhajNwbXpmaXlreHI5diJ9.mPwJumFFjJCjq45E-17_QQ",
                    userAgentPackageName: 'com.gando.rentcar.app',
                    additionalOptions: const {
                      'accessToken' : 'pk.eyJ1IjoiY2F2aWFyb3MiLCJhIjoiY2xjMW90MWx3MTFhajNwbXpmaXlreHI5diJ9.mPwJumFFjJCjq45E-17_QQ',
                      'id' : 'mapbox.mapbox-streets-v8'
                    },
                    retinaMode: MediaQuery.of(context).devicePixelRatio > 1.0,
                    // tileBounds: LatLngBounds(
                    //   LatLng(32.2934590056236, 24.328924534719548),
                    //   LatLng(21.792152188247265, 37.19854583903912),
                    // ),
                    errorImage: const NetworkImage('https://tile.openstreetmap.org/18/0/0.png'),
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
                    markers: [
                      ...List.generate(carList.length, (index) => Marker(
                        point: carList[index].latLng!,
                        width: 120,
                        height: 120,
                        builder: (context) => const Icon(Icons.location_history, color: Colors.deepOrange,),
                      ),),
                    ],
                  ),
                ],
              ),
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
                child: Container(
                  height: Get.height / 3.5,
                  // margin: const EdgeInsets.only(top: 80.0),
                  child: ListView.builder(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: carList.length,
                    itemBuilder: (context, index) {
                      scrollController.position.context.axisDirection.index == 0;
                      return HomeCardCar(index);
                    },
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
              margin: const EdgeInsets.only(top: 0.0),
              foregroundDecoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent, Colors.transparent, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0032, 0.3, 2.0, 90],
                ),
              ),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.only(top: 180, bottom: 80),
                itemCount: carList.length,
                itemBuilder: (context, index) => HomeCardCar(index,),
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
                              color: AppTheme.light),
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
                                const Icon(
                                  Icons.search,
                                  color: Colors.grey,
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
