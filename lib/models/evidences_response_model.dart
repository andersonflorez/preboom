class EvidencesResponseModel {
  late String? idEvidence;
  late String? response;

  EvidencesResponseModel(
      {required String idEvidence, String? response}) {
    // ignore: prefer_initializing_formals
    this.idEvidence = idEvidence;
    // ignore: prefer_initializing_formals
    this.response = response;
  }
    EvidencesResponseModel.firestore(dynamic evidencesResponseFirestore) {
    idEvidence = evidencesResponseFirestore["idEvidence"];
    response = evidencesResponseFirestore["response"];
  }

  Map<String, dynamic> toFirestore (){
    return {
      "idEvidence": idEvidence,
      "response": response
    };
  }
}
