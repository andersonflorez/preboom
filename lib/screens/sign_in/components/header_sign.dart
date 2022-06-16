import 'package:flutter/material.dart';

import '../../../components/line_green.dart';

class HeaderSign extends StatelessWidget {
  const HeaderSign({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.asset(
            "assets/images/banner_signin.jpg",
            fit: BoxFit.cover,
          ),
        ),
        const LineGreen(height: 10),
      ],
    );
  }
}
