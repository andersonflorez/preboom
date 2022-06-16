import 'package:flutter/material.dart';
import 'package:preboom/screens/sign_in/sign_in_screen.dart';
import 'package:preboom/states/signin_state.dart';
import 'package:provider/provider.dart';

import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
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
          TextFormField(
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
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight! * 0.1),
          DefaultButton(
              text: "Enviar",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  Future<String> response =
                      context.read<SigninState>().forgotPassword(email);

                  response.then((value) {
                    if (value == 'user-not-found') {
                      addError(error: kUserNotFound);
                      removeError(error: kInvalidEmailError);
                      removeError(error: kErrorService);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(kUserNotFound),
                        ),
                      );
                    } else if (value == 'invalid-email') {
                      addError(error: kInvalidEmailError);
                      removeError(error: kUserNotFound);
                      removeError(error: kErrorService);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(kInvalidEmailError),
                        ),
                      );
                    } else if (value == "service-error") {
                      addError(error: kErrorService);
                      removeError(error: kUserNotFound);
                      removeError(error: kInvalidEmailError);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(kErrorService),
                        ),
                      );
                    } else if (value != "") {
                      addError(error: kErrorService);
                      removeError(error: kUserNotFound);
                      removeError(error: kInvalidEmailError);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(kErrorService),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Se han enviado a tu correo electronico las instrucciones para restablecer tu contraseña."),
                          duration: Duration(seconds: 5),
                        ),
                      );
                      Navigator.of(context)
                          .pushReplacementNamed(SignInScreen.routeName);
                    }
                  });
                }
              })
        ],
      ),
    );
  }
}
