import 'package:flutter/material.dart';
import 'package:gando/widget/platform_adaptive_progress_indicator.dart';

class LoadingDialog extends StatelessWidget {
  final Color? color;

  const LoadingDialog({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: const Center(child: PlatformAdaptiveProgressIndicator()),
    );
  }
}
