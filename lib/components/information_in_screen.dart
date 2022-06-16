import 'package:flutter/material.dart';

import '../size_config.dart';

class InformationInScreen extends StatelessWidget {
  final String title;
  final String description;
  const InformationInScreen({
    Key? key, required this.title, required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(20),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight! * 0.03),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(16),
          ),
        ),
      ],
    );
  }
}
