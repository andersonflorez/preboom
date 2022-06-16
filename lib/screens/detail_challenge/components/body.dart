import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/challenge_model.dart';
import '../../../size_config.dart';
import 'evidences_form.dart';
import 'header_detail_challenge.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChallengeModel challenge =
        ModalRoute.of(context)!.settings.arguments as ChallengeModel;
    return SingleChildScrollView(
      child: Column(
        children: [
          HeaderDetailChallenge(
            image: challenge.image,
            challengeId: challenge.id,
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
              child: Column(
                children: [
                  Text(
                    challenge.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenWidth(25),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Html(
                      data: challenge.description,
                      onLinkTap: (String? url, _, __, ___) async {
                        if (!await launchUrl(Uri.parse(url!),
                            mode: LaunchMode.externalApplication)) {
                          throw 'Could not launch $url';
                        }
                      }),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  EvidencesForm(
                    challengeId: challenge.id,
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
