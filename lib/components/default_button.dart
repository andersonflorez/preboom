import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final bool? loading;
  final GestureTapCallback onPressed;
  final Color backgroundColor;

  const DefaultButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.loading,
    this.backgroundColor = kPrimaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: ElevatedButton(
        onPressed: onPressed,
        child: buildContentButton(),
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget buildContentButton() {
    if (loading != true) {
      return Text(
        text,
        style: TextStyle(
          fontSize: getProportionateScreenWidth(18),
          color: Colors.white,
        ),
      );
    } else {
      return const CircularProgressIndicator();
    }
  }
}
