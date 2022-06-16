import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:preboom/models/user_model.dart';
import 'package:preboom/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../states/signin_state.dart';

class InformationForm extends StatefulWidget {
  const InformationForm({Key? key})
      : super(key: key);

  @override
  _InformationFormState createState() => _InformationFormState();
}

class _InformationFormState extends State<InformationForm> {
  final _formKey = GlobalKey<FormState>();
  late String? email;
  late String? name;
  late String? phoneNumber;
  DateTime? birdthDate;
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
    name = context.read<SigninState>().currentUser().name;
    phoneNumber = context.read<SigninState>().currentUser().phoneNumber;
    birdthDate =
        birdthDate ?? context.read<SigninState>().currentUser().birdthDate;
    email = context.read<SigninState>().currentUser().email;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildBirdthDateFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            loading: context.watch<SigninState>().isLoading(),
            text: "Guardar",
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                UserModel? user = context.read<SigninState>().currentUser();
                user.updateUser(
                  name: name,
                  phoneNumber: phoneNumber,
                  birdthDate: birdthDate,
                );
                await context.read<SigninState>().updateUserInFirestore(user);

                  Navigator.of(context)
                      .pushReplacementNamed(HomeScreen.routeName);
                
              }
            },
          )
        ],
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      initialValue: name,
      keyboardType: TextInputType.name,
      onSaved: (newValue) => name = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kNameNullError)) {
          removeError(error: kNameNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text("Nombre completo"),
        hintText: "Ingresa tu nombre completo",
        suffixIcon: Icon(Icons.person_outline),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      initialValue: phoneNumber,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => phoneNumber = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPhoneNumberNullError)) {
          removeError(error: kPhoneNumberNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Número celular'),
        hintText: "Ingresa tu número de celular",
        suffixIcon: Icon(Icons.person_outline),
      ),
    );
  }

  TextFormField buildBirdthDateFormField() {
    var maskFormatter = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
      initialText: birdthDate != null ? DateFormat("dd/MM/yyyy").format(birdthDate!) : null,
    );
    return TextFormField(
      initialValue: birdthDate != null ? DateFormat("dd/MM/yyyy").format(birdthDate!) : null,
      keyboardType: TextInputType.number,
      inputFormatters: [maskFormatter],
      onSaved: (newValue) {
        final components = newValue!.split("/");
        if (components.length == 3) {
          final day = int.tryParse(components[0]);
          final month = int.tryParse(components[1]);
          final year = int.tryParse(components[2]);
          birdthDate = DateTime(year!, month!, day!);
        }
      },
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kBirdthDateNullError)) {
          removeError(error: kBirdthDateNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kBirdthDateNullError);
          return "";
        }
        final components = value.split("/");
        if (components.length == 3) {
          final day = int.tryParse(components[0]);
          final month = int.tryParse(components[1]);
          final year = int.tryParse(components[2]);
          if (day != null && month != null && year != null) {
            final date = DateTime(year, month, day);
            if (!(date.year == year &&
                date.month == month &&
                date.day == day)) {
              addError(error: kBirdthDateInvalidError);
              return "";
            } else {
              removeError(error: kBirdthDateInvalidError);
            }
          }
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Fecha de nacimiento'),
        hintText: "31/12/1999",
        suffixIcon: Icon(Icons.person_outline),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      readOnly: true,
      initialValue: email,
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
}
