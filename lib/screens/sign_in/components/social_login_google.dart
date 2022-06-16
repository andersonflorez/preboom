import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:preboom/screens/redirect_home/redirect_home_screen.dart';
import 'package:preboom/states/signin_state.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';

class SocialLoginGoogle extends StatelessWidget {
  const SocialLoginGoogle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool response = await context.read<SigninState>().loginGoogle();
        if (response) {
          Navigator.of(context)
              .pushReplacementNamed(RedirectHomeScreen.routeName);
        }
      },
      child: Container(
        padding: EdgeInsets.all(
          getProportionateScreenWidth(12),
        ),
        width: getProportionateScreenWidth(45),
        height: getProportionateScreenWidth(45),
        decoration: const BoxDecoration(
          color: Color(0xFFf5f6f9),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset("assets/icons/google-icon.svg"),
      ),
    );
  }
}
