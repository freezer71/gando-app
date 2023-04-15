import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/date_formatter.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/constants.dart';
import 'package:gando/controllers/chat/chat_controller.dart';
import 'package:gando/models/User.dart';
import 'package:gando/models/chat/chat.dart';
import 'package:gando/services/socket/socket_client.dart';
import 'package:gando/widget/loading_dialog.dart';
import 'package:get/get.dart';

class ChatDetail extends GetView<ChatController> {
  final User user;
  ChatDetail({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: AppTheme.darkColor,
          ),
        ),
        title: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: "${user.photo}",
                  errorWidget: (context, url, error) =>
                      Image.asset("${assetsImages}defaultImage.png"),
                ),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: SizedBox(
                width: Get.width / 1.6,
                child: Text('${user.firstname} ${user.lastname}',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                        color: AppTheme.darkColor)),
              ),
            ),
          ],
        ),
      ),
      body: GetBuilder<ChatController>(
        init: controller,
        builder: (controller) {
          print("update isakin 10 secons");
          return Column(
            children: [
              Expanded(
                child: Container(
                  child: controller.isLoading.value
                      ? const LoadingDialog()
                      : controller.chatList.isEmpty
                          ? Center(child: Text("Aucun message"))
                          : Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    reverse: true,
                                    controller: controller.scrollController,
                                    itemCount: controller.chatList.length,
                                    itemBuilder: (context, index) {
                                      bool isCurrentUser =
                                          controller.chatList[index].sender ==
                                              controller.userId;
                                      return Padding(
                                        // asymmetric padding
                                        padding: EdgeInsets.fromLTRB(
                                          isCurrentUser ? 64.0 : 16.0,
                                          4,
                                          isCurrentUser ? 16.0 : 64.0,
                                          4,
                                        ),
                                        child: Align(
                                          // align the child within the container
                                          alignment: isCurrentUser
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          child: Column(
                                            children: [
                                              DecoratedBox(
                                                // chat bubble decoration
                                                decoration: BoxDecoration(
                                                  color: isCurrentUser
                                                      ? AppTheme.primaryColor
                                                      : Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  child: Text(
                                                    "${controller.chatList[index].body}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            color: isCurrentUser
                                                                ? Colors.white
                                                                : Colors
                                                                    .black87),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                  DateFormatter()
                                                      .getVerboseDateTimeRepresentation(
                                                          controller
                                                              .chatList[index]
                                                              .sendDate!
                                                              .toLocal()),
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10))
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 24.0),
                                  alignment: Alignment.centerLeft,
                                  child: controller.isWriting
                                      ? SizedBox(
                                          height: 35.0,
                                          child: Text(
                                            "en train d'ecrire...",
                                            style: TextStyle(
                                              color: AppTheme.darkColor,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10, top: 20.0),
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: TextFormField(
                                          onChanged: (value) {
                                            controller
                                                .setIsWriting(value.isNotEmpty);
                                          },
                                          maxLength: 1000,
                                          controller: controller
                                              .messageFieldController.value,
                                          minLines: 1,
                                          maxLines: 4,
                                          style: TextStyle(
                                              color: AppTheme.darkColor),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 5.0,
                                                    vertical: 5.0),
                                            fillColor: AppTheme.light,
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  color: AppTheme.darkColor
                                                      .withOpacity(0.5),
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: 2.0,
                                                color: AppTheme.darkColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppTheme.darkColor,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(bottom: 20.0),
                                        child: FloatingActionButton(
                                          onPressed: () async {
                                            if (controller.isTyping) {
                                              Get.focusScope!.unfocus();
                                              await controller.sendMessage();
                                            }
                                          },
                                          elevation: 0,
                                          child: Icon(
                                            Icons.send,
                                            color: controller.isTyping
                                                ? AppTheme.darkColor
                                                : Colors.grey,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
