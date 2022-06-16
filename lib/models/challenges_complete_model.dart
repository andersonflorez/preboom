
import 'evidences_response_model.dart';

class ChallengesCompleteModel {
  late String idChallenge;
  late DateTime? date;
  late List<EvidencesResponseModel> evidencesResponse;

  ChallengesCompleteModel(
      {required String idChallenge,
      DateTime? date,
      List<EvidencesResponseModel>? evidencesResponse}) {
    // ignore: prefer_initializing_formals
    this.idChallenge = idChallenge;
    // ignore: prefer_initializing_formals
    this.date = date;
    this.evidencesResponse = evidencesResponse ?? [];
  }

  Map<String, dynamic> toFirestore() {
    return {
      "date": date,
      "evidencesResponse": evidencesResponse
          .where((element) => element.response != null)
          .map((e) => e.toFirestore())
          .toList()
    };
  }
}
