import 'package:flutter/material.dart';
import 'package:preboom/components/line_green.dart';

import '../../../components/footer_logos.dart';
import '../../../size_config.dart';
import 'forgot_password_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LineGreen(height: 10),
        SingleChildScrollView(
          child: SizedBox(
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
                    "Olvidé mi contraseña",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(22),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.01),
                  const Text(
                    "Ingresa tu correo electronico y te llegaran los pasos\npara restaurar la contraseña.",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.06),
                  const ForgotPasswordForm(),
                  SizedBox(height: SizeConfig.screenHeight! * 0.02),
                  const FooterLogos()
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
