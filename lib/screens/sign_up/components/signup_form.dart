import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../states/signin_state.dart';
import '../../complete_information/complete_information_screen.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  late String confirmPassword;
  final List<String> errors = [];

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConfirmPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            loading: context.watch<SigninState>().isLoading(),
            text: "Registrar",
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                //go to complete profile page
                _formKey.currentState!.save();

                Future<String> response = context
                    .read<SigninState>()
                    .createCredential(email, password);

                response.then(
                  (value) {
                    if (value == 'weak-password') {
                      addError(error: kWeakPassword);
                      removeError(error: kEmailAlreadyUse);
                      removeError(error: kErrorService);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(kWeakPassword),
                        ),
                      );
                    } else if (value == 'email-already-in-use') {
                      addError(error: kEmailAlreadyUse);
                      removeError(error: kErrorService);
                      removeError(error: kWeakPassword);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(kEmailAlreadyUse),
                        ),
                      );
                    } else if (value == "service-error") {
                      addError(error: kErrorService);
                      removeError(error: kEmailAlreadyUse);
                      removeError(error: kWeakPassword);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(kErrorService),
                        ),
                      );
                    } else if (value != "") {
                      addError(error: kErrorService);
                      removeError(error: kEmailAlreadyUse);
                      removeError(error: kWeakPassword);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(kErrorService),
                        ),
                      );
                    } else {
                      Navigator.of(context).pushReplacementNamed(
                          CompleteInformationScreen.routeName);
                    }
                  },
                );
              }
            },
          )
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kEmailNullError)) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value) &&
            errors.contains(kInvalidEmailError)) {
          removeError(error: kInvalidEmailError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Correo electrónico",
        hintText: "Ingresa tu correo electrónico",
        suffixIcon: Icon(Icons.email_outlined),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          removeError(error: kPassNullError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Contraseña",
        hintText: "Ingresa tu contraseña",
        suffixIcon: Icon(Icons.lock_outline),
        helperText: "Debes ingresar mínimo 6 letras."
      ),
    );
  }

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => confirmPassword = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kConfirmPassNullError)) {
          removeError(error: kConfirmPassNullError);
        } else if (password == value && errors.contains(kMatchPassError)) {
          removeError(error: kMatchPassError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kConfirmPassNullError);
          return "";
        } else if (password != value) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Confirmar Contraseña",
        hintText: "Re-ingresa tu contraseña",
        suffixIcon: Icon(Icons.lock_outline),
      ),
    );
  }
}
