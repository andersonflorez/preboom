class EvidencesModel {
  late String id;
  late String label;
  late String type;
  late dynamic value;
  
  EvidencesModel.to({required String id, required String label, required String type, dynamic value}){
    // ignore: prefer_initializing_formals
    this.id = id;
    // ignore: prefer_initializing_formals
    this.label = label;
    // ignore: prefer_initializing_formals
    this.type = type;
    // ignore: prefer_initializing_formals
    this.value = value;
  }

  EvidencesModel.toFirestore({required String id, required dynamic evidenceFirebase}){
    // ignore: prefer_initializing_formals
    this.id = id;
    label = evidenceFirebase["label"];
    type = evidenceFirebase["type"];
    value = evidenceFirebase["value"];
  }
}