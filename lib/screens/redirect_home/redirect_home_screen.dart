import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';
import '../../states/signin_state.dart';
import '../complete_information/complete_information_screen.dart';
import '../home/home_screen.dart';
import '../sign_in/sign_in_screen.dart';
import 'components/loading.dart';

class RedirectHomeScreen extends StatelessWidget {
  static String routeName = "/redirect_home";

  const RedirectHomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    var state = context.watch<SigninState>();

    if (!state.isLoading()) {
      if (state.isLoggedIn()) {
        if (state.currentUser().firebaseStorage) {
          return const HomeScreen();
        } else {
          return const CompleteInformationScreen();
        }
      } else {
        return const SignInScreen();
      }
    } else {
      return const Loading();
    }
  }
}
