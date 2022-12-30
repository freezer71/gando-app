
import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChannelPage extends StatelessWidget {
  const ChannelPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          color: AppTheme.backgroundColor,
        ),
      ),
      extendBody: true,

      // bottomNavigationBar: StreamMessageInput(),
      body: Column(
        children:  [
          Expanded(
            flex: 2,
            child: Container(
              width: Get.width,
              height: Get.height / 1.7,
              child: Expanded(
                child: Container(),
              ),
            ),
          ),
          // SizedBox(height: 63,)
        ],
      ),
    );
  }
}
