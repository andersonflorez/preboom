import 'package:flutter/material.dart';
import 'package:preboom/components/information_in_screen.dart';

import '../../../components/footer_logos.dart';
import '../../../components/line_green.dart';
import '../../../size_config.dart';
import 'signup_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

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
                  const InformationInScreen(
                      title: "Registrate",
                      description:
                          "Ingresa tu correo y tu contraseña para acceder al PreCamp"),
                  SizedBox(height: SizeConfig.screenHeight! * 0.06),
                  const SignupForm(),
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
