import 'package:flutter/cupertino.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/models/User.dart';
import 'package:gando/models/chat/chat.dart';
import 'package:gando/models/chat/discussion.dart';
import 'package:gando/services/auth/auth_services.dart';
import 'package:gando/services/repositories/discussion_repository.dart';
import 'package:gando/services/socket/socket_client.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  Rx<bool> isLoading = false.obs;
  List<Discussion> discussionList = [];
  List<Chat> chatList = [];
  DiscussionRepository repository = GetIt.instance.get<DiscussionRepository>();
  Rx<User> user = Get.find<AuthService>().user;
  Rx<TextEditingController> messageFieldController =
      TextEditingController().obs;
  ScrollController scrollController = ScrollController();
  SocketClient socketClient = GetIt.instance.get<SocketClient>();
  bool isCurrentUser = false;
  bool isWriting = false;
  @override
  Future<void> onInit() async {
    await getListMessage();
    update();
    super.onInit();
  }

  set setDiscussionList(List<Discussion> v) {
    discussionList.addAll(v);
    update();
  }

  void setIsWriting(bool v) {
    // IO.Socket socket = socketClient.connexion();
    isWriting = v;
    /* if (isWriting) {
      socket.emit(
        "writting",
        {
          "senderId": user.value.id,
          "recipientId": user.value.id,
          "isWritting": isWriting,
        },
      );
    }
    socket.on("writting", (data) => {print("dataato $data")});*/

    /* socket.emit(
      "message",
      {
        "id": socket.id,
        "message": "message", // Message to be sent
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      },
    );*/
    update();
  }

  Future<void> getListMessage() async {
    /* socketClient.idClient = user.value.id ?? "";
    IO.Socket socket = socketClient.connexion();
    socket.onConnect((_) {
      print('connected ${socketClient.idClient}');
    });
    socket.onDisconnect((_) => print('disconnect'));
    socket.onConnectError((_) => print('connect error $_'));
    socket.onError((_) => print('error be $_'));
    socket.on('notificationClient', (body) {
      print("boyako $body");
    });*/

    isLoading(true);
    repository.getListMessage(userId: user.value.id ?? "").then((value) {
      setDiscussionList = value;
      isLoading(false);
    }).catchError((onError) {
      isLoading(false);
      update();
      Get.snackbar('Error', onError.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.redColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 3));
    });
  }

  Future<void> getMessageDetail({required String discussionId}) async {
    isLoading(true);
    repository.getMessageDetail(discussionId: discussionId).then((value) async {
      List<Chat> chatListApi = value.messages!;
      chatListApi.sort((a, b) => b.sendDate!.compareTo(a.sendDate!));
      chatList = chatListApi;
      isLoading(false);
      print("successs ");
      update();
      await Future.delayed(Duration(milliseconds: 300));
      scrollController.jumpTo(
        scrollController.position.minScrollExtent,
      );
      print("success scrollcontroller");
      update();
    }).catchError((onError) {
      isLoading(false);
      update();
      Get.snackbar('Error', onError.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.redColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 2));
    });
  }

  Future<void> sendMessage() async {
    print("user.value.id ${user.value.id}");
    isWriting = false;
    // isLoading(true);
    try {
      chatList.add(
        Chat(
          body: messageFieldController.value.text,
          sender: user.value.id,
          recipient: "641d99acd09f7285f9ba646a",
          sendDate: chatList.first.sendDate?.add(const Duration(seconds: 5)),
        ),
      );
      ;
      chatList.sort((a, b) => b.sendDate!.compareTo(a.sendDate!));
      scrollController.jumpTo(
        scrollController.position.minScrollExtent,
      );
      Map<String, dynamic> data = {
        "sender": user.value.id,
        "recipient": "641d99acd09f7285f9ba646a",
        "message": messageFieldController.value.text,
      };
      messageFieldController.value.clear();
      update();
      repository.sendMessage(data: data);
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.redColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 3));
    } finally {
      isLoading(false);
    }
  }
}
