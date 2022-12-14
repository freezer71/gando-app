import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/views/chat/components/chat.dart';
import 'package:get/get.dart';

import 'components/demand.dart';

class ChatScreen extends GetView {
  ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0), // here the desired height
            child: AppBar(
              backgroundColor: AppTheme.primaryColor,
              automaticallyImplyLeading: false,
              bottom: TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      'Messages',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: AppTheme.backgroundColor),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Demandes',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: AppTheme.backgroundColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              ChatTabScreen(),
              DemandTabScreen(),
            ],
          ),
        ),
      );
}
