import 'package:flutter/material.dart';

import '../../../components/footer_logos.dart';
import '../../../components/line_green.dart';
import '../../../size_config.dart';
import '../../complete_information/components/information_form.dart';

class ProfileCamp extends StatelessWidget {
  const ProfileCamp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const LineGreen(height: 10),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight! * 0.05,
                  ),
                  Text(
                    "Completa tu informacion",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(22),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.01),
                  const Text(
                    "Si alguno de tus datos estan mal, aca puedes modificarlos",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.06),
                  const InformationForm(),
                  SizedBox(height: SizeConfig.screenHeight! * 0.02),
                  const FooterLogos()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
