import 'package:flutter/material.dart';

import '../../../size_config.dart';
import '../../forgot_password/forgot_password_screen.dart';
import '../../sign_up/sign_up_screen.dart';

class AccessLinksRegisterAndForgot extends StatelessWidget {
  const AccessLinksRegisterAndForgot({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(SignUpScreen.routeName);
          },
          child: SizedBox(
            width: getProportionateScreenWidth(166),
            child: const Text(
              "Regístrate a 12.1 Camp",
              textAlign: TextAlign.center,
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        Container(
          height: getProportionateScreenHeight(15),
          width: 1,
          decoration: const BoxDecoration(color: Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ForgotPasswordScreen.routeName);
          },
          child: SizedBox(
            width: getProportionateScreenWidth(166),
            child: const Text(
              "Olvidé mi contraseña",
              textAlign: TextAlign.center,
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
