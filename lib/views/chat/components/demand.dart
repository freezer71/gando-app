
import 'package:flutter/material.dart';

import '../../../config/textstyle.dart';

class DemandTabScreen extends StatelessWidget {
  const DemandTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child:  Center(
      child: Text(
        'Demandes',
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 22,
            color: AppTheme.primaryColor),
      ),
    ),);
  }
}
