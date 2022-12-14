import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';

class MyAppbar extends StatelessWidget {
  const MyAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppTheme.secondaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Text(
            'Detail du véhicule',
            style: TextStyle(
              color: AppTheme.secondaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.menu,
              color: AppTheme.secondaryColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
