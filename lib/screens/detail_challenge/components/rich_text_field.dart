import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zefyrka/zefyrka.dart';

import '../../../constants.dart';
import '../../../models/evidences_model.dart';
import '../../../models/evidences_response_model.dart';
import '../../../size_config.dart';

class RichTextField extends StatefulWidget {
  const RichTextField({
    Key? key,
    required this.evidencesModel,
    required this.evidenceResponseModel,
    required this.complete,
  }) : super(key: key);

  final EvidencesModel evidencesModel;
  final EvidencesResponseModel evidenceResponseModel;
  final bool complete;

  @override
  State<RichTextField> createState() => _RichTextFieldState();
}

class _RichTextFieldState extends State<RichTextField> {
  ZefyrController _controller = ZefyrController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      widget.evidenceResponseModel.response = jsonEncode(_controller.document);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.complete) {
      final doc = NotusDocument.fromJson(
          jsonDecode(widget.evidenceResponseModel.response!));
      _controller = ZefyrController(doc);
    }
    return Container(
      padding: const EdgeInsets.all(10),
      height: getProportionateScreenHeight(350),
      decoration: BoxDecoration(
        border: Border.all(color: kPrimaryColor),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.evidencesModel.label,
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: getProportionateScreenWidth(14),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(290) - 30,
            child: ZefyrEditor(
              readOnly: widget.complete,
              expands: false,
              maxHeight: getProportionateScreenHeight(290) - 30,
              controller: _controller,
            ),
          ),
          if (!widget.complete)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
              ),
              height: 20,
              child: ZefyrToolbar.basic(controller: _controller, hideHeadingStyle: true,),
            ),
        ],
      ),
    );
  }
}
