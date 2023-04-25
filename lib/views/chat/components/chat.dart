import 'package:flutter/material.dart';
import 'package:gando/constants.dart';
import 'package:gando/controllers/chat/chat_controller.dart';
import 'package:gando/services/socket/socket_client.dart';
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
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Dismissible(
                              key: UniqueKey(),
                              background: Container(
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                color: AppTheme.redColor,
                                child: const Icon(
                                    Icons.restore_from_trash_rounded),
                              ),
                              secondaryBackground: Container(
                                alignment: Alignment.centerRight,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                color: AppTheme.redColor,
                                child: const Icon(
                                    Icons.restore_from_trash_rounded),
                              ),
                              confirmDismiss: (value) async {
                                final confirmed = await Get.dialog(
                                  AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    backgroundColor: AppTheme.light,
                                    title: Row(
                                      children: [
                                        Image.asset(
                                          "${assetsImages}avertissement.png",
                                          width: 30.0,
                                        ),
                                        SizedBox(width: 25.0),
                                        Expanded(
                                          child: Text(
                                            "Avertissement",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  color: AppTheme.redColor,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    content: Text(
                                      "Voulez-vous vraiment supprimer cette discussion ?",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: AppTheme.darkColor,
                                          ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Get.back(result: false);
                                        },
                                        child: Text(
                                          "Non",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: AppTheme.primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          Get.back(result: true);
                                        },
                                        child: Text(
                                          "Oui",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: AppTheme.redColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                                return confirmed;
                              },
                              onDismissed: (direction) {
                                print("discussion delete ");
                              },
                              child: ChatCard(
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
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ),
      ),
    );
  }
}
