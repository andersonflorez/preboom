import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:preboom/states/signin_state.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../states/challenges_state.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int listChallenges = context.watch<ChallengesState>().numberChallenges();
    int listChallengesComplete =
        context.watch<SigninState>().numberChallengsComplete();
    double percent = (listChallengesComplete / listChallenges).isInfinite ||
            (listChallengesComplete / listChallenges).isNaN
        ? 0
        : listChallengesComplete / listChallenges;

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Column(
        children: [
          Text(
            "Retos",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(20),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          LinearPercentIndicator(
            animation: true,
            width: SizeConfig.screenWidth! - getProportionateScreenWidth(40),
            lineHeight: 20,
            barRadius: const Radius.circular(8),
            percent: percent > 1 ? 1 : percent,
            backgroundColor: kPrimaryColor,
            progressColor: kSecondaryColor,
            center: Text(
              "${(percent * 100).toInt()}%",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
