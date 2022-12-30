import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/views/home/home.dart';
import 'package:get/get.dart';
import 'channel_page.dart';

class ChannelListPage extends StatefulWidget {
  final controller;
  const ChannelListPage({
    Key? key, required this.controller
  }) : super(key: key);

  @override
  State<ChannelListPage> createState() => _ChannelListPageState();
}

class _ChannelListPageState extends State<ChannelListPage> {


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Container(

      ),
    );
  }


}



