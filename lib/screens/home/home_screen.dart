import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:preboom/size_config.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../states/signin_state.dart';
import '../redirect_home/components/loading.dart';
import '../sign_in/sign_in_screen.dart';
import 'components/challenges_camp.dart';
import 'components/information_camp.dart';
import 'components/profile_camp.dart';
import 'components/requirements_camp.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedItem = "challenges";

  @override
  Widget build(BuildContext context) {
    var state = context.read<SigninState>();
    Stream<DocumentSnapshot<Map<String, dynamic>>> queryUserSnaptshot =
        FirebaseFirestore.instance
            .collection("users")
            .doc(state.currentUser().uid)
            .snapshots();

    queryUserSnaptshot.listen((event) {
      state.updateCurrentUserFirestore(event.data());
    });

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: kPrimaryColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _bottomAction(
                icon: Icons.checklist_outlined,
                item: "requirements",
                onPressed: () {
                  setState(() {
                    selectedItem = "requirements";
                  });
                },
              ),
              _bottomAction(
                icon: Icons.info_outline,
                item: "information",
                onPressed: () {
                  setState(() {
                    selectedItem = "information";
                  });
                },
              ),
              SizedBox(
                width: getProportionateScreenWidth(48),
              ),
              _bottomAction(
                icon: Icons.person_outline,
                item: "profile",
                onPressed: () {
                  setState(() {
                    selectedItem = "profile";
                  });
                },
              ),
              _bottomAction(
                icon: Icons.logout_outlined,
                onPressed: () {
                  context.read<SigninState>().loguot();
                  Navigator.of(context)
                      .pushReplacementNamed(SignInScreen.routeName);
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: kSecondaryColor,
        child: Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(2)),
          child: SvgPicture.asset(
            "assets/icons/logo_precamp2.svg",
            color: kPrimaryColor,
          ),
        ),
        onPressed: () {
          setState(() {
            selectedItem = "challenges";
          });
        },
      ),
      body: SafeArea(
        child: body(),
      ),
    );
  }

  Widget _bottomAction(
      {required IconData icon,
      String? item,
      required GestureTapCallback onPressed}) {
    return IconButton(
      icon: Icon(icon),
      color: item == selectedItem ? kSecondaryColor : Colors.white,
      onPressed: onPressed,
    );
  }

  Widget body() {
    switch (selectedItem) {
      case "challenges":
        return const ChallengesCamp();
      case "profile":
        return const ProfileCamp();
      case "information":
        return const InformationCamp();
      case "requirements":
        return const RequirementsCamp();
      default:
        return const Loading();
    }
  }
}
