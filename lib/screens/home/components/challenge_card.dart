import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:preboom/models/challenge_model.dart';
import 'package:preboom/screens/detail_challenge/detail_challenge_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../size_config.dart';

class ChallengeCard extends StatelessWidget {
  final ChallengeModel challenge;
  final bool complete;

  const ChallengeCard({
    Key? key,
    required this.challenge,
    required this.complete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: InkWell(
        onTap: () {
          if (DateTime.now()
                  .compareTo(challenge.startDate.add(const Duration(days: 1))) >
              -1) {
            Navigator.of(context).pushNamed(
              DetailChallengeScreen.routeName,
              arguments: challenge,
            );
          }
        },
        child: SizedBox(
          width: getProportionateScreenWidth(330),
          height: getProportionateScreenWidth(132),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Hero(
                  tag: "header_detail_challenge_${challenge.id}",
                  child: CachedNetworkImage(
                    placeholder: (context, url) =>
                        Image.asset("assets/images/placeholder_precamp.jpg"),
                    imageUrl: challenge.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),

                ),
                if (DateTime.now().compareTo(
                        challenge.startDate.add(const Duration(days: 1))) >
                    -1)
                  //Enable
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF343434).withOpacity(0.4),
                          const Color(0xFF343434).withOpacity(0.2),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  )
                else
                  //Disable
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF343434).withOpacity(0.4),
                          const Color(0xFF343434).withOpacity(0.2),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Container(
                      foregroundDecoration: const BoxDecoration(
                        color: Colors.grey,
                        backgroundBlendMode: BlendMode.saturation,
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: getProportionateScreenWidth(170),
                          child: Text(
                            challenge.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenWidth(18),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(130),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (complete)
                              Icon(
                                Icons.check_circle_outline,
                                color: Colors.white,
                                size: getProportionateScreenWidth(18),
                              )
                            else
                              const Spacer(),
                            Text(
                              "Inicio\n${DateFormat.yMMMd().format(challenge.startDate)}",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(18),
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
