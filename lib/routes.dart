import 'package:flutter/material.dart';

import 'screens/complete_information/complete_information_screen.dart';
import 'screens/detail_challenge/detail_challenge_screen.dart';
import 'screens/forgot_password/forgot_password_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/redirect_home/redirect_home_screen.dart';
import 'screens/sign_in/sign_in_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName: (context) => const SignInScreen(),
  CompleteInformationScreen.routeName: (context) =>
      const CompleteInformationScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  RedirectHomeScreen.routeName: (context) => const RedirectHomeScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  DetailChallengeScreen.routeName: (context) => const DetailChallengeScreen(),
};
