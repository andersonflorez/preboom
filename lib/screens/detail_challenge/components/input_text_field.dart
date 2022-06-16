import 'package:flutter/material.dart';

import '../../../models/evidences_model.dart';
import '../../../models/evidences_response_model.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    Key? key,
    required this.evidencesModel,
    required this.evidenceResponseModel,
    required this.complete,
  }) : super(key: key);

  final EvidencesModel evidencesModel;
  final EvidencesResponseModel evidenceResponseModel;
  final bool complete;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: complete,
      initialValue: evidenceResponseModel.response,
      onChanged: (value) {
        evidenceResponseModel.response = value;
      },
      decoration: InputDecoration(
        label: Text(evidencesModel.label),
        hintText: evidencesModel.label,
      ),
    );
  }
}
