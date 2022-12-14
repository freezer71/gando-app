


import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../config/config.dart';


class ChatService extends GetxService {
  Future<ChatService> init() async => this;

  final client = StreamChatClient(Config.apiKey, logLevel: Level.INFO);

  Channel? channel;

  @override
  void onReady() async{
    super.onReady();
    await initChatService();
  }


  Future initChatService() async{
    await client.connectUser(
      User(id: 'gando'),
      Config.token,
    );

    channel = client.channel('messaging', id: 'flutterdevs');

    await channel!.watch();
  }

}