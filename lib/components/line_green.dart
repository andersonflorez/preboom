import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class LineGreen extends StatelessWidget {
  final double height;
  const LineGreen({
    Key? key, required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: getProportionateScreenHeight(height),
      decoration: const BoxDecoration(
        color: kSecondaryColor,
      ),
    );
  }
}