import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/main.dart';
import 'package:gando/services/chat/chat_service.dart';
import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';


class ChatPageScreen extends StatefulWidget {
  const ChatPageScreen({Key? key}) : super(key: key);

  @override
  State<ChatPageScreen> createState() => _ChatPageScreenState();
}

class _ChatPageScreenState extends State<ChatPageScreen> {


  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatService());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child){
        return StreamChat(
          client: controller.client,
          child: child,
        );
      },
      home: const ChannelPage(),
    );
  }
}

class ChannelPage extends StatelessWidget {
  const ChannelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: const [
          Expanded(
            child: StreamMessageListView(),
          ),
          StreamMessageInput()
        ],
      ),
    );
  }
}

