// ignore_for_file: file_names

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

typedef CallbackFunction = void Function(String serviseName);

class SignInWith extends StatelessWidget {
  final Color Bgcolor;
  final IconData serviceIcon;
  final String serviceName;
  final Size media;
  final CallbackFunction onClick;
  const SignInWith(
    this.Bgcolor,
    this.serviceIcon,
    this.serviceName,
    this.media,
    this.onClick,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(serviceName),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Bgcolor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        width: media.width * 0.70,
        height: 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              serviceIcon,
              size: 20,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "Se connecter avec ",
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
            Text(
              serviceName,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
