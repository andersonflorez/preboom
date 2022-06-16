import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../components/line_green.dart';

class HeaderDetailChallenge extends StatelessWidget {
  final String image;
  final String challengeId;
  const HeaderDetailChallenge(
      {Key? key, required this.image, required this.challengeId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Hero(
              tag: "header_detail_challenge_$challengeId",
              child: SizedBox(
                width: double.infinity,
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      Image.asset("assets/images/placeholder_precamp.jpg"),
                  imageUrl: image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ],
        ),
        const LineGreen(height: 10),
      ],
    );
  }
}
