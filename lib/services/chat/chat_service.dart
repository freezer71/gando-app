


import 'package:get/get.dart';
import '../../config/config.dart';


class ChatService extends GetxService {
  Future<ChatService> init() async => this;


  @override
  void onReady() async{
    super.onReady();
    await initChatService();
  }

  Future initChatService() async{

  }

}