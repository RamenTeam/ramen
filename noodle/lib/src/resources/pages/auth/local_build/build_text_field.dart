import 'package:flutter/material.dart';

Widget buildTextField(
    {required String hintText,
    required BuildContext context,
    required TextEditingController controller}) {
  return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderSide: BorderSide(
                  color: Theme.of(context).highlightColor, width: 0.3),
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: hintText),
      ));
}
