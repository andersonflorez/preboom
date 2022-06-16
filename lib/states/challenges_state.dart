import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:preboom/models/challenge_model.dart';

class ChallengesState with ChangeNotifier {
     
  List<ChallengeModel> _challengesStateModel = [];

  ChallengesState() {
    queryChallenges();
  }

  List<ChallengeModel> getAllChallenges() => _challengesStateModel;

  int numberChallenges() => _challengesStateModel.length;

  void queryChallenges() {
    Stream<QuerySnapshot> _queryChallenges = FirebaseFirestore.instance.collection("challenges").orderBy("startDate", descending: false).snapshots();
    _queryChallenges.listen((event) {
      _challengesStateModel = [];
      for (var element in event.docs) {
        _challengesStateModel
            .add(ChallengeModel.toFirestore(element.id, element.data()));
      }
      notifyListeners();
    });
  }
}
