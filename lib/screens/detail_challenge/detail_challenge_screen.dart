import 'package:flutter/material.dart';
import 'package:preboom/models/challenge_model.dart';

import 'components/body.dart';

class DetailChallengeScreen extends StatelessWidget {
  static String routeName = "/detail_challenge";

  const DetailChallengeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ChallengeModel challenge =
        ModalRoute.of(context)!.settings.arguments as ChallengeModel;

    return Scaffold(
      appBar: AppBar(title: Text(challenge.name),),
      body: const Body(),
    );
  }
}