import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:gando/models/User.dart';
import 'package:gando/models/chat/discussion.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class ChatCard extends StatelessWidget {
  final VoidCallback onTap;
  final Discussion discussion;
  ChatCard({Key? key, required this.onTap, required this.discussion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Get.height / 10,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Row(
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.width / 1.6,
                          child: Text(
                              '${discussion.anotherUser?.first.firstname} ${discussion.anotherUser?.first.lastname}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                      color: AppTheme.darkColor)),
                        ),
                        SizedBox(
                          width: Get.width / 1.8,
                          child: Text("${discussion.lastMessage?.first.body}",
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      color: AppTheme.darkColor)),
                        ),
                        Text(
                            '${DateFormat('d MMM yyyy').format(discussion.lastMessage!.first.sendDate!)}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                    color: AppTheme.darkColor)),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                      color: AppTheme.redColor, shape: BoxShape.circle),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
