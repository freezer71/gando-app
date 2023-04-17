import 'package:flutter/material.dart';

import '../config/textstyle.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    this.context,
    required this.title,
    this.leading,
    this.action,
  })  : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  final BuildContext? context;
  String? title = '';
  final Widget? leading;
  final List<Widget>? action;

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.light,
      centerTitle: true,
      automaticallyImplyLeading: false,
      elevation: 2,
      leading: widget.leading,
      actions: widget.action,
      title: Text(
        widget.title!,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 18,
            overflow: TextOverflow.ellipsis,
            color: AppTheme.darkColor),
      ),
    );
  }
}
