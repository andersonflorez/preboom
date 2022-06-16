import 'package:flutter/material.dart';
import 'package:preboom/screens/redirect_home/redirect_home_screen.dart';
import 'package:preboom/states/signin_state.dart';
import 'package:provider/provider.dart';

import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
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
          SizedBox(height: getProportionateScreenHeight(10)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            loading: context.watch<SigninState>().isLoading(),
            text: "Ingresar",
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Future<String> response =
                    context.read<SigninState>().loginCredential(email, password);

                response.then((value) {
                  if (value == 'user-not-found') {
                    addError(error: kUserNotFound);
                    removeError(error: kWrongPassword);
                    removeError(error: kInvalidEmailError);
                    removeError(error: kErrorService);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(kUserNotFound),
                      ),
                    );
                  } else if (value == 'wrong-password') {
                    addError(error: kWrongPassword);
                    removeError(error: kUserNotFound);
                    removeError(error: kInvalidEmailError);
                    removeError(error: kErrorService);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(kWrongPassword),
                      ),
                    );
                  } else if (value == 'invalid-email') {
                    addError(error: kInvalidEmailError);
                    removeError(error: kUserNotFound);
                    removeError(error: kWrongPassword);
                    removeError(error: kErrorService);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(kInvalidEmailError),
                      ),
                    );
                  } else if (value == "service-error") {
                    addError(error: kErrorService);
                    removeError(error: kUserNotFound);
                    removeError(error: kWrongPassword);
                    removeError(error: kInvalidEmailError);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(kErrorService),
                      ),
                    );
                  } else if (value != "") {
                    addError(error: kErrorService);
                    removeError(error: kUserNotFound);
                    removeError(error: kWrongPassword);
                    removeError(error: kInvalidEmailError);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(kErrorService),
                      ),
                    );
                  } else {
                    Navigator.of(context)
                        .pushReplacementNamed(RedirectHomeScreen.routeName);
                  }
                });
              }
            },
          ),
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
        suffixIcon: Icon(Icons.lock_outline)
      ),
    );
  }
}
