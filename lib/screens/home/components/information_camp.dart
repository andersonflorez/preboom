import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../components/footer_logos.dart';
import '../../../components/information_in_screen.dart';
import '../../../components/line_green.dart';
import '../../../size_config.dart';

class InformationCamp extends StatelessWidget {
  const InformationCamp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot<Map<String, dynamic>>> _queryInformationCamp =
        FirebaseFirestore.instance
            .collection("informationScreens")
            .doc("information_camp")
            .snapshots();

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: _queryInformationCamp,
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const LineGreen(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.screenHeight! * 0.05,
                        ),
                        const InformationInScreen(
                          title: "Información Adicional",
                          description:
                              "A continuación podrás encontrar toda la información necesaria de nuestro 12.1 Camp",
                        ),
                        SizedBox(height: getProportionateScreenWidth(30)),
                        Html(data: snapshot.data!.get("description")),
                        SizedBox(height: SizeConfig.screenHeight! * 0.05),
                        const FooterLogos()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
