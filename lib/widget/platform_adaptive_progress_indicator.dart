import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';

class PlatformAdaptiveProgressIndicator extends StatelessWidget {
  const PlatformAdaptiveProgressIndicator() : super();

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && Platform.isIOS) {
      //isIOS
      return const CupertinoActivityIndicator();
    } else if (!kIsWeb && Platform.isAndroid) {
      //isANDROID
      return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor));
    } else if (kIsWeb) {
      //isWEB
      return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor));
    } else {
      return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor));
    }
  }
}
