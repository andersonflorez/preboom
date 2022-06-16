import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:preboom/components/default_button.dart';
import 'package:preboom/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

import '../../../models/challenges_complete_model.dart';
import '../../../models/evidences_model.dart';
import '../../../models/evidences_response_model.dart';
import '../../../models/user_model.dart';
import '../../../size_config.dart';
import '../../../states/signin_state.dart';
import 'input_text_field.dart';
import 'multiple_selection_field.dart';
import 'rich_text_field.dart';
import 'upload_files_field.dart';

class EvidencesForm extends StatefulWidget {
  final String challengeId;

  const EvidencesForm({Key? key, required this.challengeId}) : super(key: key);

  @override
  State<EvidencesForm> createState() => _EvidencesFormState();
}

class _EvidencesFormState extends State<EvidencesForm> {
  late ChallengesCompleteModel challengeCompleteModel;
  bool complete = false;

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _queryEvidences = FirebaseFirestore.instance
        .collection("challenges")
        .doc(widget.challengeId)
        .collection("evidences")
        .orderBy("order", descending: false)
        .snapshots();

    ChallengesCompleteModel? challengeCompleteState =
        context.watch<SigninState>().getChallengeComplete(widget.challengeId);
    if (challengeCompleteState != null) {
      challengeCompleteModel = ChallengesCompleteModel(
          idChallenge: challengeCompleteState.idChallenge,
          date: challengeCompleteState.date);
      complete = true;
    } else {
      challengeCompleteModel =
          ChallengesCompleteModel(idChallenge: widget.challengeId);
    }

    return StreamBuilder<QuerySnapshot>(
      stream: _queryEvidences,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Error inesperado');
        }

        if (snapshot.hasData) {
          List<Widget> evidencesWidgets = [];

          challengeCompleteModel.evidencesResponse = [];
          for (var evidences in snapshot.data!.docs) {
              EvidencesModel evidencesModel = EvidencesModel.toFirestore(
                id: evidences.id,
                evidenceFirebase: evidences.data(),
              );

              EvidencesResponseModel evidenceResponseModel;
              if (challengeCompleteState != null) {
                try {
                  List<EvidencesResponseModel> evidencesResponseState =
                      challengeCompleteState.evidencesResponse
                          .where((element) =>
                              element.idEvidence == evidencesModel.id)
                          .toList();

                  evidenceResponseModel = EvidencesResponseModel(
                    idEvidence: evidencesResponseState.first.idEvidence!,
                    response: evidencesResponseState.fold(
                        "",
                        (previousValue, element) => previousValue == ""
                            ? element.response
                            : "$previousValue|${element.response}"),
                  );
                } catch (e) {
                  evidenceResponseModel =
                      EvidencesResponseModel(idEvidence: evidencesModel.id);
                }
              } else {
                evidenceResponseModel =
                    EvidencesResponseModel(idEvidence: evidencesModel.id);
              }

              if (evidencesModel.type == "input_text") {
                evidencesWidgets.add(
                  Column(
                    children: [
                      SizedBox(height: getProportionateScreenHeight(13)),
                      InputTextField(
                        evidencesModel: evidencesModel,
                        evidenceResponseModel: evidenceResponseModel,
                        complete: complete,
                      ),
                      SizedBox(height: getProportionateScreenHeight(13)),
                    ],
                  ),
                );
              } else if (evidencesModel.type == "rich_text") {
                evidencesWidgets.add(
                  Column(
                    children: [
                      SizedBox(height: getProportionateScreenHeight(13)),
                      RichTextField(
                        evidencesModel: evidencesModel,
                        evidenceResponseModel: evidenceResponseModel,
                        complete: complete,
                      ),
                      SizedBox(height: getProportionateScreenHeight(13)),
                    ],
                  ),
                );
              } else if (evidencesModel.type == "files") {
                evidencesWidgets.add(
                  Column(
                    children: [
                      SizedBox(height: getProportionateScreenHeight(13)),
                      UploadFilesField(
                        evidencesModel: evidencesModel,
                        challengesCompleteModel: challengeCompleteModel,
                        evidenceResponseModel: evidenceResponseModel,
                        complete: complete,
                      ),
                      SizedBox(height: getProportionateScreenHeight(13)),
                    ],
                  ),
                );
              } else if (evidencesModel.type == "multiple_selection") {
                evidencesWidgets.add(
                  Column(
                    children: [
                      SizedBox(height: getProportionateScreenHeight(13)),
                      MultipleSelectionField(
                        evidencesModel: evidencesModel,
                        evidenceResponseModel: evidenceResponseModel,
                        complete: complete,
                      ),
                      SizedBox(height: getProportionateScreenHeight(13)),
                    ],
                  ),
                );
              } else {
                evidencesWidgets.add(
                  Text(evidencesModel.label),
                );
              }
              challengeCompleteModel.evidencesResponse
                  .add(evidenceResponseModel);
            }

          return Column(
            children: [
              ...evidencesWidgets,
              if (!complete) SizedBox(height: getProportionateScreenHeight(20)),
              DefaultButton(
                text: "Guardar",
                onPressed: () async {
                  int errors = 0;
                  for (var element
                      in challengeCompleteModel.evidencesResponse) {
                    if (element.response == "" || element.response == null) {
                      errors++;
                    } else {
                      errors--;
                    }
                  }
                  if (errors +
                          challengeCompleteModel.evidencesResponse.length ==
                      0) {
                    UserModel? user = context.read<SigninState>().currentUser();
                    challengeCompleteModel.date = DateTime.now();
                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(user.uid)
                        .update({
                      "challengesComplete.${challengeCompleteModel.idChallenge}":
                          challengeCompleteModel.toFirestore()
                    });
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Completa toda la evidencia."),
                      ),
                    );
                  }
                },
              ),
              const Text(
                "Después de guardar no podrás modificar tu respuesta.",
                textAlign: TextAlign.center,
              )
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
