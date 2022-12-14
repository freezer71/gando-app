// ignore_for_file: unnecessary_new, prefer_const_constructors, unused_field
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/home/home_controller.dart';
import 'package:gando/controllers/home/tabs/tab_controller.dart';
import 'package:gando/views/chat/chat_screen.dart';
import 'package:gando/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:gando/views/products/available/available_car_screen.dart';
import 'package:gando/views/settings/settings_screen.dart';
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
    super.initState();
    tabController.customInit();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
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
  SnakeShape snakeShape = SnakeShape.circle;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = true;

  Color selectedColor = AppTheme.primaryColor;
  Color unselectedColor = AppTheme.secondaryColor;

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: SnakeNavigationBar.color(
        height: 65,
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        padding: padding,
        backgroundColor: Colors.white.withOpacity(0.9),
        snakeViewColor: selectedColor.withOpacity(0.9),
        selectedItemColor: snakeShape == SnakeShape.indicator ? selectedColor : null,
        unselectedItemColor: unselectedColor,
        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,
        elevation: 16,
        currentIndex: tabController.pageIndex.value,
        onTap: (index) => setState(() => tabController.pageIndex.value = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled, size: 30)),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_outline_outlined, size: 30)),
          BottomNavigationBarItem(icon: Icon(Icons.mail_outlined, size: 30)),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, size: 25,)),
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
      body: GetX<TabScreenController>(
        init: tabController,
        builder: (tabController) => tabController.pageIndex.value == 0
            ? HomeScreen()
            : tabController.pageIndex.value == 1
            ? const ArticleListScreen()
            : tabController.pageIndex.value == 2
            ? ChatScreen()
            : const SettingsScreen(),
      ),
    );
  }
}
