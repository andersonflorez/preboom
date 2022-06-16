import 'package:flutter/material.dart';
import 'package:preboom/constants.dart';
import 'package:preboom/size_config.dart';

import '../../../models/evidences_model.dart';
import '../../../models/evidences_response_model.dart';

class MultipleSelectionField extends StatefulWidget {
  final EvidencesModel evidencesModel;
  final EvidencesResponseModel evidenceResponseModel;
  final bool complete;

  const MultipleSelectionField(
      {Key? key,
      required this.evidencesModel,
      required this.evidenceResponseModel,
      required this.complete})
      : super(key: key);

  @override
  State<MultipleSelectionField> createState() => _MultipleSelectionFieldState();
}

class _MultipleSelectionFieldState extends State<MultipleSelectionField> {
  @override
  Widget build(BuildContext context) {
    return !widget.complete
        ? Column(children: _options())
        : Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  widget.evidencesModel.label,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    color: kPrimaryColor,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  widget.evidenceResponseModel.response ?? "",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    color: kTextColor,
                  ),
                ),
              ),
            ],
          );
  }

  List<Widget> _options() {
    List<Widget> items = [];
    items.add(
      SizedBox(
        width: double.infinity,
        child: Text(widget.evidencesModel.label,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(15),
              color: kPrimaryColor,
            )),
      ),
    );
    widget.evidencesModel.value.forEach((element) {
      items.add(
        Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(35),
                  width: getProportionateScreenWidth(35),
                  child: Radio<String>(
                    activeColor: kSecondaryColor,
                    value: element,
                    groupValue: widget.evidenceResponseModel.response,
                    onChanged: (String? value) {
                      setState(() {
                        widget.evidenceResponseModel.response = value!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(300),
                  child: Text(
                    element,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15)
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(5)),
          ],
        ),
      );
    });

    return items;
  }
}
