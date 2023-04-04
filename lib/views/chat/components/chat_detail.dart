import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/controllers/chat/chat_controller.dart';
import 'package:gando/models/User.dart';
import 'package:gando/widget/loading_dialog.dart';
import 'package:get/get.dart';

class ChatDetail extends GetView<ChatController> {
  final User user;
  ChatDetail({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("atoooo");
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
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/av.png'),
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
      body: Container(
        child: GetBuilder<ChatController>(
          init: controller,
          builder: (controller) {
            return Container(
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
                                          controller.user.value.id;
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
                                      child: DecoratedBox(
                                        // chat bubble decoration
                                        decoration: BoxDecoration(
                                          color: isCurrentUser
                                              ? AppTheme.primaryColor
                                              : Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Text(
                                            "${controller.chatList[index].body}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: isCurrentUser
                                                        ? Colors.white
                                                        : Colors.black87),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10, top: 20.0),
                              width: double.infinity,
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: 20.0),
                                      child: Icon(
                                        Icons.add,
                                        color: AppTheme.darkColor,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      onChanged: (value) {
                                        controller
                                            .setIsWriting(value.isNotEmpty);
                                        // controller.numberTextDescription.value = value.length;
                                      },
                                      maxLength: 1000,
                                      controller: controller
                                          .messageFieldController.value,
                                      minLines: 1,
                                      maxLines: 4,
                                      style:
                                          TextStyle(color: AppTheme.darkColor),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 5.0),
                                        fillColor: AppTheme.light,
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                              overflow: TextOverflow.visible,
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
                                        if (controller.isWriting) {
                                          Get.focusScope!.unfocus();
                                          await controller.sendMessage();
                                        }
                                      },
                                      elevation: 0,
                                      child: Icon(
                                        Icons.send,
                                        color: controller.isWriting
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
            );
          },
        ),
      ),
    );
  }
}
