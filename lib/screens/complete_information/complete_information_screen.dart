import 'package:flutter/material.dart';

import 'components/body.dart';

class CompleteInformationScreen extends StatelessWidget {
  static String routeName = "/complete_information_full";
  const CompleteInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completa tu información'),
      ),
      body: const Body(),
    );
  }
}
