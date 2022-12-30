import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/views/chat/components/chat.dart';
import 'package:get/get.dart';

import 'components/demand.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Messages'),
    const Tab(text: 'Demandes'),
  ];
  int _activeTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _activeTabIndex = _tabController.index;
        });
      }
    });
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            bottom: TabBar(
              controller: _tabController,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              automaticIndicatorColorAdjustment: false,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: AppTheme.light,
              indicatorWeight: 2.0,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppTheme.darkColor,
              ),
              tabs: myTabs
                  .map<Widget>((myTab) => Tab(
                child: Container(
                  // width: Get.width / 3 -
                  //     10, // - 10 is used to make compensate horizontal padding
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(10.0),
                  //   color:
                  //   _activeTabIndex == myTabs.indexOf(myTab)
                  //       ? Colors.transparent
                  //       : Color(0xffA4BDD4),
                  // ),
                  margin:
                  EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      myTab.text.toString(),
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: _activeTabIndex == myTabs.indexOf(myTab) ? AppTheme.light : AppTheme.darkColor),
                    ),
                  ),
                ),
              )).toList(),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            ChatTabScreen(),
            DemandTabScreen(),
          ],
        ),
      ),
    );
  }

}
