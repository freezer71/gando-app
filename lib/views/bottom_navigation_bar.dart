// ignore_for_file: unnecessary_new, prefer_const_constructors, unused_field
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/home/home_controller.dart';
import 'package:gando/controllers/home/tabs/tab_controller.dart';
import 'package:gando/views/chat/chat_screen.dart';
import 'package:gando/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:gando/views/products/available/available_car_screen.dart';
import 'package:gando/views/settings/mygando_screen.dart';
import 'package:get/get.dart';

import 'admin/articles_list_screen.dart';
import 'authentication/signin/signin_screen.dart';

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarPage> createState() => _BottomNavigationBarPage();
}

class _BottomNavigationBarPage extends State<BottomNavigationBarPage> {
  final tabController = Get.put(TabScreenController());
  // final homeController = Get.put(HomeController());
  late ScrollController controller;

  @override
  void initState() {
    tabController.customInit();
    controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    // tabController.dispose();
    super.dispose();
  }

  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final BorderRadius _borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(18),
    topRight: Radius.circular(18),
  );

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = EdgeInsets.zero;

  final int _selectedItemPosition = 0;
  SnakeShape snakeShape = SnakeShape.indicator;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = true;

  Color selectedColor = AppTheme.redColor;
  Color unselectedColor = Colors.transparent;

  Gradient selectedGradient =
  const LinearGradient(colors: [Colors.red, Colors.amber]);
  Gradient unselectedGradient =
  const LinearGradient(colors: [Colors.red, Colors.blueGrey]);

  Color? containerColor;
  List<Color> containerColors = [
    const Color(0xFFFDE1D7),
    const Color(0xFFE4EDF5),
    const Color(0xFFE7EEED),
    const Color(0xFFF4E4CE),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      // backgroundColor: HexColor(AppTheme.secondaryColorString!).withOpacity(0.4),
      body: GetBuilder<TabScreenController>(
        init: tabController,
        builder: (tabController) => tabController.pageIndex.value == 0
            ? HomeScreen()
            : tabController.pageIndex.value == 1
            ? ArticleListScreen()
            : tabController.pageIndex.value == 2
            ? ChatScreen()
            : const MyGandoScreen(),
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        height: 70,
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        padding: padding,
        backgroundColor: AppTheme.light,
        snakeViewColor: selectedColor.withOpacity(0.9),
        selectedItemColor: snakeShape == SnakeShape.indicator ? selectedColor : null,
        unselectedItemColor: unselectedColor,
        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,
        elevation: 0,
        currentIndex: tabController.pageIndex.value,
        onTap: (index) => setState(() => tabController.pageIndex.value = index),
        items:  [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled , size: 30, color: tabController.pageIndex.value == 0 ? AppTheme.redColor : AppTheme.secondaryColor.withOpacity(0.6),)),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_outline_outlined, size: 30, color: tabController.pageIndex.value == 1 ? AppTheme.redColor : AppTheme.secondaryColor.withOpacity(0.6))),
          BottomNavigationBarItem(icon: Stack(
            fit: StackFit.expand,
            children: [
              Icon(Icons.message, size: 30, color: tabController.pageIndex.value == 2 ? AppTheme.redColor : AppTheme.secondaryColor.withOpacity(0.6)),
              Positioned(
                top: 12,
                right: 25,
                child: Container(
                  width: 8,
                  height: 8,
                  margin: const  EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: AppTheme.redColor,
                      borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ],
          )),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, size: 25, color: tabController.pageIndex.value == 3 ? AppTheme.redColor : AppTheme.secondaryColor.withOpacity(0.6))),
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
    );
  }
}
