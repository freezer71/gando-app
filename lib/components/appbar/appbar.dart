import 'package:flutter/material.dart';

class AppBarHome extends StatefulWidget {
  final TabController tabController;
  const AppBarHome({super.key, required this.tabController});

  @override
  State<AppBarHome> createState() => _AppBarHomeState();
}

class _AppBarHomeState extends State<AppBarHome> {
  final TextStyle tabTextStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontFamily: "Inter",
  );
  @override
  Widget build(BuildContext context) {
    // get media size
    Size size = MediaQuery.of(context).size;

    double width = size.width;
    double height = size.height;

    return Container(
      width: width,
      height: height * 0.25, // 10%
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.only(top: 40),
      // tab bar
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 30,
            width: width * 0.65, // 65%
            margin: const EdgeInsets.only(bottom: 20),
            decoration: const BoxDecoration(
              color: Color(0xFFEBEBEB),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: TabBar(
              controller: widget.tabController,
              tabs: [
                Tab(
                  child: Text(
                    "Plan",
                    style: tabTextStyle,
                  ),
                ),
                Tab(
                  child: Text(
                    "Liste",
                    style: tabTextStyle,
                  ),
                )
              ],
              // dividerColor: Colors.red,
              indicatorPadding: const EdgeInsets.all(2),
              indicator: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.red,
            width: width,
            height: 30,
          )
        ],
      ),
    );
  }
}
