import 'package:flutter/material.dart';
import 'package:gando/controllers/chat/chat_controller.dart';
import 'package:gando/views/chat/components/chat_detail.dart';
import 'package:gando/widget/chat_card.dart';
import 'package:gando/widget/loading_dialog.dart';
import 'package:get/get.dart';
import 'package:gando/config/textstyle.dart';

class ChatTabScreen extends GetView<ChatController> {
  ChatTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: GetBuilder<ChatController>(
          init: controller,
          builder: (controller) => Container(
            child: controller.isLoading.value
                ? const LoadingDialog()
                : controller.discussionList.isEmpty
                    ? Center(
                        child: Text(
                        "Aucun message",
                        style: TextStyle(color: AppTheme.darkColor),
                      ))
                    : ListView.builder(
                        itemCount: controller.discussionList.length,
                        itemBuilder: (context, index) {
                          return ChatCard(
                            discussion: controller.discussionList[index],
                            onTap: () {
                              controller.getMessageDetail(
                                  discussionId:
                                      controller.discussionList[index].id!);
                              Get.to(() => ChatDetail(
                                    user: controller.discussionList[index]
                                        .anotherUser!.first,
                                  ));
                            },
                          );
                        },
                      ),
          ),
        ),
      ),
    );
  }
}
