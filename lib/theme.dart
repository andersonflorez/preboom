import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Neutra",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
  );
}

ThemeData themeDark() {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0xFF373737),
    fontFamily: "Neutra",
    appBarTheme: appBarThemeDark(),
    textTheme: textThemeDark(),
    inputDecorationTheme: inputDecorationThemeDark(),
    radioTheme: radioThemeDataDark()
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: const BorderSide(color: kPrimaryColor),
    gapPadding: 10,
  );

  return InputDecorationTheme(
    labelStyle: const TextStyle(
      color: kPrimaryColor,
    ),
    suffixIconColor: kPrimaryColor,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 40,
      vertical: 20,
    ),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
    errorBorder: outlineInputBorder,
    focusedErrorBorder: outlineInputBorder,
    errorStyle: const TextStyle(fontSize: 0),
  );
}

InputDecorationTheme inputDecorationThemeDark() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: const BorderSide(color: kPrimaryColor),
    gapPadding: 10,
  );

  return InputDecorationTheme(
    labelStyle: const TextStyle(color: kPrimaryColor, fontSize: 18),
    suffixIconColor: kPrimaryColor,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 40,
      vertical: 20,
    ),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
    errorBorder: outlineInputBorder,
    focusedErrorBorder: outlineInputBorder,
    errorStyle: const TextStyle(fontSize: 0),
    focusColor: kTertiaryColor,
    hintStyle: const TextStyle(color: kTertiaryColor),
    helperStyle: const TextStyle(color: kTertiaryColor),
  );
}

RadioThemeData radioThemeDataDark() {
  Color getColor(Set<MaterialState> states) {
    return kTertiaryColor;
  }

  return RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith(getColor),
  );
}

TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(color: kTextColor, fontSize: 13),
    bodyText2: TextStyle(color: kTextColor, fontSize: 13),
  );
}

TextTheme textThemeDark() {
  return const TextTheme(
    bodyText1: TextStyle(color: kTertiaryColor, fontSize: 13),
    bodyText2: TextStyle(color: kTertiaryColor, fontSize: 13),
    subtitle1: TextStyle(color: Colors.white),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    centerTitle: true,
    color: Colors.white,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Color(0xFF8b8b8b),
      fontSize: 18,
    ),
  );
}

AppBarTheme appBarThemeDark() {
  return const AppBarTheme(
    centerTitle: true,
    color: Colors.black,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    iconTheme: IconThemeData(color: Colors.white70),
    titleTextStyle: TextStyle(
      color: Colors.white70,
      fontSize: 18,
    ),
  );
}
