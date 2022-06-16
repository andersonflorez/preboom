import 'package:firebase_auth/firebase_auth.dart';
import 'package:preboom/models/evidences_response_model.dart';
import 'package:preboom/utils.dart';

import 'challenges_complete_model.dart';

class UserModel {
  late String uid;
  late String? name;
  late DateTime? birdthDate;
  late int? age;
  late String email;
  late String? phoneNumber;
  late bool firebaseStorage = false;
  late bool emailVerfied = false;
  late List<ChallengesCompleteModel> challengesComplete = [];

  UserModel.userFirebase(User user) {
    uid = user.uid;
    name = user.displayName;
    birdthDate = null;
    age = null;
    email = user.email!;
    phoneNumber = user.phoneNumber;
    firebaseStorage = false;
    emailVerfied = user.emailVerified;
  }

  UserModel.empty();

  UserModel.firestore(this.uid, Map<String, dynamic>? userFirebase) {
    name = userFirebase!["name"];
    birdthDate = userFirebase["birdthDate"].toDate();
    age = Utils.calculateAge(birdthDate);
    email = userFirebase["email"];
    phoneNumber = userFirebase["phoneNumber"];
    firebaseStorage = true;
    emailVerfied = userFirebase["emailVerfied"];

    Map<dynamic, dynamic>? challengesCompleteFirestore =
        userFirebase["challengesComplete"];

    if (challengesCompleteFirestore != null) {
      challengesCompleteFirestore.forEach(
        (key, value) {
          List<dynamic> evidencesResponseFirestore = value["evidencesResponse"];

          challengesComplete.add(
            ChallengesCompleteModel(
              idChallenge: key,
              date: value["date"].toDate(),
              evidencesResponse: evidencesResponseFirestore
                  .map((e) => EvidencesResponseModel.firestore(e))
                  .toList(),
            ),
          );
        },
      );
    }
  }

  void updateUser(
      {String? uid,
      String? name,
      DateTime? birdthDate,
      int? age,
      String? email,
      String? phoneNumber,
      bool? firebaseStorage,
      bool? emailVerfied}) {
    if (uid != null) {
      this.uid = uid;
    }
    if (name != null) {
      this.name = name;
    }
    if (birdthDate != null) {
      this.birdthDate = birdthDate;
      this.age = Utils.calculateAge(this.birdthDate);
    }
    if (email != null) {
      this.email = email;
    }
    if (phoneNumber != null) {
      this.phoneNumber = phoneNumber;
    }
    if (firebaseStorage != null) {
      this.firebaseStorage = firebaseStorage;
    }

    if (emailVerfied != null) {
      this.emailVerfied = emailVerfied;
    }
  }

  toFirestore() {
    return {
      "name": name,
      "birdthDate": birdthDate,
      "email": email,
      "phoneNumber": phoneNumber,
      "emailVerfied": emailVerfied
    };
  }
}
