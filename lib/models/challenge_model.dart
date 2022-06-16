class ChallengeModel {
  late String id;
  late String description;
  late String name;
  late String image;
  late DateTime startDate;
  late DateTime endDate;

  ChallengeModel.toFirestore(this.id, dynamic challengeFirebase) {
    description = challengeFirebase["description"];
    name = challengeFirebase["name"];
    image = challengeFirebase["image"];
    startDate = challengeFirebase["startDate"].toDate();
    endDate = challengeFirebase["endDate"].toDate();
  }
}
