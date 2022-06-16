import 'package:flutter/material.dart';

import '../../../components/information_in_screen.dart';
import '../../../size_config.dart';
import 'access_links_register_and_forgot.dart';
import '../../../components/footer_logos.dart';
import 'header_sign.dart';
import 'signin_form.dart';
import 'social_login_google.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const HeaderSign(),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight! * 0.04),
                  const InformationInScreen(
                    title: "Bienvenido al PreCamp",
                    description:
                        "Inicia sesión con tu correo electrónico y contraseña \no regístrate si es tu primera vez.\nTambien puedes acceder con tu cuenta de Gmail.",
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.05),
                  const SignInForm(),
                  SizedBox(height: SizeConfig.screenHeight! * 0.02),
                  const AccessLinksRegisterAndForgot(),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  const SocialLoginGoogle(),
                  const FooterLogos(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
