import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:gando/config/date_formatter.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/models/User.dart';
import 'package:gando/models/chat/chat.dart';
import 'package:gando/models/chat/discussion.dart';
import 'package:gando/services/auth/auth_services.dart';
import 'package:gando/services/repositories/discussion_repository.dart';
import 'package:gando/services/socket/socket_client.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

class ChatController extends GetxController {
  Rx<bool> isLoading = false.obs;
  List<Discussion> discussionList = [];
  List<Chat> chatList = [];
  DiscussionRepository repository = GetIt.instance.get<DiscussionRepository>();
  final box = GetStorage();
  String userId = "";

  Rx<TextEditingController> messageFieldController =
      TextEditingController().obs;
  ScrollController scrollController = ScrollController();
  String? recipientID;
  SocketClient socketClient = GetIt.instance.get<SocketClient>();

  bool isCurrentUser = false;
  bool isWriting = false;
  bool isTyping = false;
  Timer? timer;

  late StreamSubscription _subWriting;
  late StreamSubscription _subMessage;

  Stream? streamWriting;
  Stream? streamMessage;

  @override
  Future<void> onInit() async {
    await _getUserId();
    await getListMessage();
    isWriting = false;
    update();
    streamWriting = socketClient.getTyping;
    streamMessage = socketClient.getResponse;

    _subMessage = streamMessage!.listen((event) {
      chatList.add(event);
      chatList.sort((a, b) => b.sendDate!.compareTo(a.sendDate!));
      scrollController.jumpTo(
        scrollController.position.minScrollExtent,
      );
      update();
    });
    timer ??= Timer.periodic(const Duration(seconds: 80), (Timer t) {
      update();
    });
    _subWriting = streamWriting!.listen((event) {
      isWriting = event;
      update();
    });
    super.onInit();
  }

  @override
  void dispose() {
    socketClient.dispose();
    _subWriting.cancel();
    _subMessage.cancel();
    super.dispose();
  }

  set setDiscussionList(List<Discussion> v) {
    discussionList.addAll(v);
    update();
  }

  void setIsWriting(bool v) {
    isTyping = v;
    socketClient.isTyping(
        senderId: userId, recipientId: recipientID!, isWriting: v);
    update();
  }

  Future<void> _getUserId() async {
    if (box.hasData('userId') && box.read('userId') != null) {
      userId = await box.read('userId');
      printInfo(info: 'userId============> : $userId');
    }
  }

  Future<void> getListMessage() async {
    isLoading(true);
    repository.getListMessage(userId: userId).then((value) {
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
      recipientID =
          value.sender?.compareTo(userId) == 0 ? value.recipient : value.sender;
      chatList = value.messages!;
      isLoading(false);
      isWriting = false;
      socketClient.isTyping(
          senderId: userId, recipientId: recipientID!, isWriting: false);
      update();
      chatList.sort((a, b) => b.sendDate!.compareTo(a.sendDate!));
      await Future.delayed(Duration(milliseconds: 200));
      scrollController.jumpTo(
        scrollController.position.minScrollExtent,
      );
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
    isWriting = false;
    socketClient.isTyping(
        senderId: userId, recipientId: recipientID!, isWriting: false);
    try {
      chatList.add(
        Chat(
          body: messageFieldController.value.text,
          sender: userId,
          recipient: recipientID,
          sendDate: DateTime.now().toUtc(),
        ),
      );
      chatList.sort((a, b) => b.sendDate!.compareTo(a.sendDate!));
      await Future.delayed(const Duration(milliseconds: 200));
      scrollController.jumpTo(
        scrollController.position.minScrollExtent,
      );
      Map<String, dynamic> data = {
        "sender": userId,
        "recipient": recipientID,
        "message": messageFieldController.value.text,
      };
      messageFieldController.value.clear();
      update();
      await repository.sendMessage(data: data);
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.redColor,
          margin: const EdgeInsets.only(
            top: 20,
          ),
          duration: const Duration(seconds: 3));
    }
  }
}
