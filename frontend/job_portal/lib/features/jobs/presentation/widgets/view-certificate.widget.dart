import 'dart:convert';
import 'package:pretty_json/pretty_json.dart';
import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';

class ViewCertificateWidget extends StatelessWidget {
  // static JsonDecoder decoder = JsonDecoder();
  // static JsonEncoder encoder = JsonEncoder.withIndent('  ');

  // String prettyPrintJson(Map<String, dynamic> object) {
  //   var prettyString = encoder.convert(object);
  //   String outputString = "";
  //   prettyString.split('\n').forEach((element) {
  //     outputString = (outputString + element);
  //     return;
  //   });
  //   return outputString;
  // }

  final Map<String, dynamic> certificate;
  const ViewCertificateWidget({
    super.key,
    required this.certificate,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: StyledText(
          text: prettyJson(
            certificate,
            indent: 2,
          ),
          // prettyPrintJson(
          //   certificate,
          // ),
        ),
      ),
    );
  }
}
