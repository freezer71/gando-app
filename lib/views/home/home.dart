import 'package:flutter/material.dart';
import 'package:gando/components/appbar/appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: width,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //app bar
              Container(
                color: Colors.red,
                child: Column(
                  children: [
                    AppBarHome(
                      tabController: tabController,
                    ), //Plan / Liste
                    // Container()
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                width: width,
                height: height * 0.60, // 90%
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    Text(
                      'Flutter map widget',
                      style: TextStyle(color: Colors.black),
                    ),
                    Text('CAR LIST'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
