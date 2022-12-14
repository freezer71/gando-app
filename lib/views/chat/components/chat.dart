
import 'package:flutter/material.dart';

import '../../../config/textstyle.dart';
import '../conversations.dart';

class ChatTabScreen extends StatelessWidget {
  const ChatTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child:  Center(
      child: Text(
        'Messages',
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 22,
            color: AppTheme.primaryColor),
      ),
    ),);
  }
}
