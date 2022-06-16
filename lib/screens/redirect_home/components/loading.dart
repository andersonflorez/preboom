import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset("assets/icons/logo_preboom.svg"),
      ),
    );
  }
}
