import 'package:flutter/material.dart';
import 'package:preboom/models/challenges_complete_model.dart';
import 'package:preboom/states/signin_state.dart';
import 'package:provider/provider.dart';

import '../../../models/challenge_model.dart';
import '../../../size_config.dart';
import '../../../states/challenges_state.dart';
import 'challenge_card.dart';

class ListChallenges extends StatefulWidget {
  const ListChallenges({
    Key? key,
  }) : super(key: key);

  @override
  State<ListChallenges> createState() => _ListChallengesState();
}

class _ListChallengesState extends State<ListChallenges> {
  @override
  Widget build(BuildContext context) {
    List<ChallengeModel> listChallenges =
        context.watch<ChallengesState>().getAllChallenges();
    List<ChallengesCompleteModel> listChallengesComplete =
        context.watch<SigninState>().getChallengesComplete();
    return Column(
      children: [
        ...listChallenges.map((ChallengeModel challenge) {
          return Column(
            children: [
              ChallengeCard(
                challenge: challenge,
                complete: listChallengesComplete.where((element) => element.idChallenge== challenge.id).isNotEmpty,
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
            ],
          );
        }),
        SizedBox(height: getProportionateScreenHeight(20)),
      ],
    );
  }
}
