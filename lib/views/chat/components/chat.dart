
import 'package:flutter/material.dart';
import 'package:gando/services/chat/chat_service.dart';
import 'package:get/get.dart';

import '../../../config/textstyle.dart';
import '../widget/channel_list_page.dart';

class ChatTabScreen extends StatelessWidget {
  ChatTabScreen({Key? key}) : super(key: key);

  final controller = Get.put(ChatService());

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => Container(
        child: child,
      ),
      home: ChannelListPage(controller: controller),
    );
  }
}
