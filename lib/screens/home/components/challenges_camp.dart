import 'package:flutter/material.dart';
import 'package:preboom/size_config.dart';

import 'home_header.dart';
import 'list_challenges.dart';

class ChallengesCamp extends StatelessWidget {
  const ChallengesCamp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          const HomeHeader(),
          SizedBox(height: getProportionateScreenHeight(20)),
          const ListChallenges(),
        ],
      ),
    );
  }
}
