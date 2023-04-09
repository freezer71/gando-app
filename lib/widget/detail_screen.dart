import 'package:flutter/material.dart';
import 'package:gando/config/textstyle.dart';

class DetailScreen extends StatelessWidget {
  final String header;
  final String? value;
  const DetailScreen({Key? key, required this.header, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(header,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppTheme.darkColor,
                  fontSize: 16,
                )),
        const SizedBox(
          height: 10,
        ),
        Text(value == null || value == "" ? "N/A" : value!,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: AppTheme.darkColor,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
