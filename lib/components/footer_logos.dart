import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../size_config.dart';

class FooterLogos extends StatelessWidget {
  const FooterLogos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          "assets/icons/logo_preboom.svg",
          width: SizeConfig.screenWidth! * 0.3,
        ),
        SvgPicture.asset(
          "assets/icons/logo_mci.svg",
          width: SizeConfig.screenWidth! * 0.3,
        ),
      ],
    );
  }
}
