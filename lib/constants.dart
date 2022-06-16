import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF9b2eea);
const kSecondaryColor = Color(0xFF47ff82);
const kTertiaryColor = Color(0xFFE9e9e9);
const kTextColor = Color(0xFF000000);

const kAnimationDuration = Duration(milliseconds: 200);

// Form Error

final RegExp emailValidatorRegExp = RegExp(
    r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$");
const String kEmailNullError = "Ingresa tu correo electronico";
const String kInvalidEmailError = "Ingresa un correo valido";
const String kPassNullError = "Ingresa tu contraseña";
const String kConfirmPassNullError = "Ingresa tu confirmacion de contraseña";
const String kShortPassError = "La contraseña es muy corta";
const String kMatchPassError = "Las contraseñas no coinciden";
const String kNameNullError = "Ingresa tu nombre";
const String kPhoneNumberNullError = "Ingresa tu numero celular";
const String kBirdthDateNullError = "Ingresa la fecha de cumpleaños";
const String kBirdthDateInvalidError = "Fecha de cumpleaños invalida";
const String kUserNotFound = "Usuario no encontrado";
const String kWrongPassword = "Contraseña incorrecta";
const String kWeakPassword = "La contraseña proporcionada es demasiado débil";
const String kEmailAlreadyUse = "El correo ya existe.";
const String kErrorService = "Ha sucedido un problema inesperado.";

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: kTextColor),
  );
}
