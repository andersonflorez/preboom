import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:preboom/constants.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;
import 'package:url_launcher/url_launcher.dart';

import '../../../models/challenges_complete_model.dart';
import '../../../models/evidences_model.dart';
import '../../../models/evidences_response_model.dart';
import '../../../models/user_model.dart';
import '../../../size_config.dart';
import '../../../states/signin_state.dart';

class UploadFilesField extends StatefulWidget {
  const UploadFilesField({
    Key? key,
    required this.evidencesModel,
    required this.evidenceResponseModel,
    required this.challengesCompleteModel,
    required this.complete,
  }) : super(key: key);

  final EvidencesModel evidencesModel;
  final EvidencesResponseModel evidenceResponseModel;
  final ChallengesCompleteModel challengesCompleteModel;
  final bool complete;

  @override
  State<UploadFilesField> createState() => _UploadFilesFieldState();
}

class _UploadFilesFieldState extends State<UploadFilesField> {
  Map<String, double> listProgressPercent = {};
  List<UploadTask> uploadTaskList = [];

  @override
  void dispose() {
    for (var element in uploadTaskList) {
      element.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: !widget.complete
          ? Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(56),
                  child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: getProportionateScreenWidth(250),
                          child: Text(
                            widget.evidencesModel.label,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.upload_file_outlined,
                          color: Colors.black,
                        )
                      ],
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: kSecondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      FileType fileType;
                      if (widget.evidencesModel.value == "video") {
                        fileType = FileType.video;
                      } else if (widget.evidencesModel.value == "audio") {
                        fileType = FileType.audio;
                      } else if (widget.evidencesModel.value == "image") {
                        fileType = FileType.image;
                      } else {
                        fileType = FileType.any;
                      }
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        allowMultiple: true,
                        type: fileType,
                      );

                      if (result != null) {
                        for (var element in result.paths) {
                          File file = File(element!);
                          String fileExtension = p.extension(file.path);
                          String fileName =
                              p.basenameWithoutExtension(file.path);
                          String nameFileStorage =
                              "$fileName-${context.read<SigninState>().currentUser().uid}$fileExtension";

                          try {
                            UploadTask uploadTask = FirebaseStorage.instance
                                .ref(
                                    'challengesEvidencesFiles/$nameFileStorage')
                                .putFile(file);

                            uploadTaskList.add(uploadTask);
                            setState(() {
                              listProgressPercent[fileName] = 0;
                            });

                            uploadTask.snapshotEvents.listen(
                              (TaskSnapshot taskSnapshot) async {
                                switch (taskSnapshot.state) {
                                  case TaskState.running:
                                    if (mounted) {
                                      setState(() {
                                        listProgressPercent[fileName] =
                                            (taskSnapshot.bytesTransferred /
                                                taskSnapshot.totalBytes);
                                      });
                                    }
                                    break;
                                  case TaskState.paused:
                                    break;
                                  case TaskState.canceled:
                                    if (mounted) {
                                      setState(() {
                                        listProgressPercent[fileName] = 0;
                                      });
                                    }
                                    break;
                                  case TaskState.error:
                                    // Handle unsuccessful uploads
                                    break;
                                  case TaskState.success:
                                    if (mounted) {
                                      setState(() {
                                        listProgressPercent[fileName] = 1;
                                      });
                                    }
                                    if (widget.evidenceResponseModel.response !=
                                        null) {
                                      EvidencesResponseModel
                                          evidencesResponseAddFile =
                                          EvidencesResponseModel(
                                              idEvidence:
                                                  widget.evidencesModel.id,
                                              response: await uploadTask.storage
                                                  .ref(
                                                      'challengesEvidencesFiles/$nameFileStorage')
                                                  .getDownloadURL());
                                      widget.challengesCompleteModel
                                          .evidencesResponse
                                          .add(evidencesResponseAddFile);
                                    } else {
                                      widget.evidenceResponseModel.response =
                                          await uploadTask.storage
                                              .ref(
                                                  'challengesEvidencesFiles/$nameFileStorage')
                                              .getDownloadURL();
                                    }

                                    if (widget.challengesCompleteModel.date !=
                                        null) {
                                      UserModel? user = context
                                          .read<SigninState>()
                                          .currentUser();

                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(user.uid)
                                          .update(
                                        {
                                          "challengesComplete.${widget.challengesCompleteModel.idChallenge}.evidencesResponse":
                                              FieldValue.arrayUnion([
                                            widget.evidenceResponseModel
                                                .toFirestore()
                                          ])
                                        },
                                      );
                                    }

                                    break;
                                }
                              },
                            );
                          } catch (e) {
                            widget.evidenceResponseModel.response = "";
                          }
                        }
                      }
                    },
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                if (listProgressPercent.entries.isNotEmpty)
                  Column(
                    children: [
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: SizeConfig.screenWidth! -
                              getProportionateScreenWidth(40),
                          child: const Text(
                            "Subiendo archivos, espera a que la barra cargue",
                          ),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                    ],
                  ),
                ...listProgressPercent.entries.map((value) {
                  return Column(
                    children: [
                      LinearPercentIndicator(
                        width: SizeConfig.screenWidth! -
                            getProportionateScreenWidth(40),
                        lineHeight: 20,
                        barRadius: const Radius.circular(8),
                        percent: value.value,
                        backgroundColor: kPrimaryColor,
                        progressColor: kSecondaryColor,
                        center: Text(
                          value.value == 1 ? 'Completado' : value.key,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(5)),
                    ],
                  );
                }).toList(),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...widget.evidenceResponseModel.response!.split("|").map(
                  (element) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _launchUrl(element);
                          },
                          child: const Text(
                            "Descargar Archivo",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: kPrimaryColor),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(4)),
                      ],
                    );
                  },
                ),
              ],
            ),
    );
  }

  void _launchUrl(_url) async {
    if (!await launchUrl(Uri.parse(_url), mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $_url';
    }
  }
}
